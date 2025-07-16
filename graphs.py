#!/usr/bin/env python3

import matplotlib.pyplot as plt
import numpy as np
import sys

width  = 96
height = 48
values = 5
months = 12

def years(data):
    return data.shape[0]

def xs(data):
    return np.arange(years(data))

def gmean(data):
    if data.shape != (height, width):
        raise Exception(f"{data.shape} is an invalid shape for gmean")

    dlat = 180 / height
    lat = np.array([-90 + (i - 0.5) * dlat for i in range(1, height + 1)])
    tmp1 = np.cos(np.deg2rad(lat))                                                # weighing factors pole-to-pole
    tmp2 = np.transpose([tmp1 for i in range(width)])                             # ...replicated to all longitudes
    return np.sum(data * tmp2) / np.sum(tmp2)

def year_gmean(data):
    if data.shape != (months, height, width):
        raise Exception(f"{data.shape} is an invalid shape for year_gmean")

    return np.mean(np.vectorize(gmean, signature = "(m,n)->()")(data))

def all_gmean(data):
    return np.vectorize(year_gmean, signature = "(m,n,o)->()")(data)

def read_vals(path):
    with open(path, "rb") as file:
        data = np.frombuffer(file.read(), np.float32)
        years = len(data) // (months * values * height * width)

        data = data.reshape((years, months, values, height, width))
        return {
            "tmm" : data[:, :, 0, :, :], # temperature
            "tamm": data[:, :, 1, :, :], # air temperature
            "tomm": data[:, :, 2, :, :], # ocean temperature
            "qmm" : data[:, :, 3, :, :], # atmospheric quhumidity
            "iccm": data[:, :, 4, :, :], # ice cover
        }["tmm"]

px = 1/plt.rcParams['figure.dpi']
fig, ax = plt.subplots(figsize=(1300*px, 1300*px))

extractions_x1 = read_vals("mscm/extractions/X1.bin")
ax.plot(xs(extractions_x1), all_gmean(extractions_x1), label = "CTRL", linewidth = 3)

extractions_x2 = read_vals("mscm/extractions/X2.bin")
ax.plot(xs(extractions_x2), all_gmean(extractions_x2), label = "2xCO2", linewidth = 3, color = "red")

spinup = read_vals("mscm/spinup-run.bin")
ax.plot(xs(spinup), all_gmean(spinup), label = "Spinup", color="black", linestyle="dashed")

for name in [
    "X2-A2-V2-C2",
    "X2-A1-V2-C1",
    "X1-A1-V2-C1",
    "X2-A2-V1-C1",
    "X1-A2-V1-C1",
    "X2-A1-V1-C2",
    "X1-A1-V1-C2",
    "X2-A0-V1-C0",
]:
    file = f"mscm/runs/{name}.bin"
    data = read_vals(file)
    ax.plot(xs(data) + 15, all_gmean(data), label = name, linestyle="dotted")
plt.ylabel(r"$T_{surf}$ in °C", fontsize="xx-large")
plt.xlabel("Year", fontsize="xx-large")
plt.legend()

plt.savefig("img/some-runs.svg", bbox_inches = "tight")
