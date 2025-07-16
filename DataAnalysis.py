#!/usr/bin/env python3

import numpy as np
import sys

import argparse
parser = argparse.ArgumentParser()

parser.add_argument("-c", "--control", help = "Control run file")
parser.add_argument("-r", "--run",     help = "Actual run file")
parser.add_argument("-t", "--typst",   help = "Enable Typst table output", action = "store_true")
args = parser.parse_args()

width  = 96
height = 48
values = 5
months = 12

def gmean(data, region):
    if data.shape != (height, width):
        raise Exception(f"{data.shape} is an invalid shape for gmean")

    dlat = 180 / height
    lat = np.array([-90 + (i - 0.5) * dlat for i in range(1, height + 1)])
    tmp1 = np.cos(np.deg2rad(lat))                                                # weighing factors pole-to-pole
    tmp2 = np.array([tmp1[i] if region(lat[i]) else 0 for i in range(len(tmp1))]) # ...with possible region selector applied
    tmp3 = np.transpose([tmp2 for i in range(width)])                             # ...replicated to all longitudes
    return np.sum(data * tmp3) / np.sum(tmp3)

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
        }

vals = read_vals(args.run    )["tmm"][-1]
ctrl = read_vals(args.control)["tmm"][-1]

globaal    = lambda lat: True
polar      = lambda lat: np.abs(lat) >= 60
equatorial = lambda lat: np.abs(lat) <= 30

def tmean(data, region):
    return np.mean(np.vectorize(lambda data: gmean(data, region), signature = "(m,n)->()")(data))

vals_global = tmean(vals, globaal)
ctrl_global = tmean(ctrl, globaal)

vals_polar = tmean(vals, polar)
ctrl_polar = tmean(ctrl, polar)

vals_equatorial = tmean(vals, equatorial)
ctrl_equatorial = tmean(ctrl, equatorial)

diff_global     = vals_global     - ctrl_global
diff_polar      = vals_polar      - ctrl_polar
diff_equatorial = vals_equatorial - ctrl_equatorial

if args.typst:
    def pretty(name):
        import re
        return re.match(".*/([^.]+)", name)[1]

    print(f"[{pretty(args.run)}], [{pretty(args.control)}], [{diff_global:.5f}], [{diff_polar:.5f}], [{diff_equatorial:.5f}],")
else:
    print(f"        │  Globaal  │   Polar   │ Equatorial")
    print(f"────────┼───────────┼───────────┼───────────")
    print(f"run     │ {vals_global:9.5f} │ {vals_polar:9.5f} │ {vals_equatorial:9.5f}")
    print(f"control │ {ctrl_global:9.5f} │ {ctrl_polar:9.5f} │ {ctrl_equatorial:9.5f}")
    print(f"diff    │ {diff_global:9.5f} │ {diff_polar:9.5f} │ {diff_equatorial:9.5f}")
