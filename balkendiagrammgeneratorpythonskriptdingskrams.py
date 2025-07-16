#!/usr/bin/env python3

import numpy as plt
import matplotlib.pyplot as np

feedbacks = (
    r"$\Delta T$",
    r"$\sum_i \Delta T_i$",
    r"$\Delta T_F$",
    r"$\Delta T_A$",
    r"$\Delta T_V$",
    r"$\Delta T_C$",
    r"$\Delta \~T_A$",
    r"$\Delta \~T_C$",
    r"$\Delta \~T_V$",
    r"$\Delta \~T_{AC}$",
    r"$\Delta \~T_{AV}$",
    r"$\Delta \~T_{CV}$",
)

px = 1/np.rcParams['figure.dpi']
fig, ax = np.subplots(figsize=(1300*px, 1300*px))

np.hlines(0, 0.5, 12.5, color="black", linestyles="dashed")
ax.bar_label(ax.bar(1, 2.498, 0.8, color="red"), padding=10, fmt = "%.3f")
ax.bar_label(ax.bar(2, 2.1869, 0.8, color="darkred"), padding=10, fmt = "%.3f")
np.vlines(2.5, -0.27, 2.5, color="black", linestyles="dashed")

ax.bar_label(ax.bar(3, 0.3162, 0.8, alpha=0), padding=10, fmt = "%.3f")
ax.bar(2.65, 0.33352, 0.08, color="orange")
ax.bar(2.75, 0.32268, 0.08, color="orange")
ax.bar(2.85, 0.30983, 0.08, color="orange")
ax.bar(2.95, 0.29975, 0.08, color="orange")
ax.bar(3.05, 0.33302, 0.08, color="orange")
ax.bar(3.15, 0.32236, 0.08, color="orange")
ax.bar(3.25, 0.30930, 0.08, color="orange")
ax.bar(3.35, 0.29924, 0.08, color="orange")

ax.bar_label(ax.bar(4, 0.0838, 0.8, alpha=0), padding=10, fmt = "%.3f")
ax.bar(3.65, 0.08629, 0.08, color="black")
ax.bar(3.75, 0.08534, 0.08, color="black")
ax.bar(3.85, 0.08246, 0.08, color="black")
ax.bar(3.95, 0.08206, 0.08, color="black")
ax.bar(4.05, 0.08579, 0.08, color="black")
ax.bar(4.15, 0.08503, 0.08, color="black")
ax.bar(4.25, 0.08193, 0.08, color="black")
ax.bar(4.35, 0.08155, 0.08, color="black")

ax.bar_label(ax.bar(5, 2.0560, 0.8, alpha=0), padding=10, fmt = "%.3f")
ax.bar(4.65, 2.06908, 0.08, color="blue")
ax.bar(4.75, 2.06975, 0.08, color="blue")
ax.bar(4.85, 2.06526, 0.08, color="blue")
ax.bar(4.95, 2.06648, 0.08, color="blue")
ax.bar(5.05, 2.04539, 0.08, color="blue")
ax.bar(5.15, 2.04683, 0.08, color="blue")
ax.bar(5.25, 2.04154, 0.08, color="blue")
ax.bar(5.35, 2.04335, 0.08, color="blue")

ax.bar_label(ax.bar(6, -0.2691, 0.8, alpha=0), padding=10, fmt = "%.3f")
ax.bar(5.65, -0.26386, 0.08, color="purple")
ax.bar(5.75, -0.26319, 0.08, color="purple")
ax.bar(5.85, -0.26481, 0.08, color="purple")
ax.bar(5.95, -0.26359, 0.08, color="purple")
ax.bar(6.05, -0.27470, 0.08, color="purple")
ax.bar(6.15, -0.27326, 0.08, color="purple")
ax.bar(6.25, -0.27546, 0.08, color="purple")
ax.bar(6.35, -0.27365, 0.08, color="purple")

np.vlines(6.5, -0.27, 2.5, color="black", linestyles="dashed")
ax.bar_label(ax.bar(7, 0.3626, 0.8, color="green"), padding=10, fmt = "%.3f")
ax.bar_label(ax.bar(8, 0.3335, 0.8, color="turquoise"), padding=10, fmt = "%.3f")
ax.bar_label(ax.bar(9, 2.1906, 0.8, color="#f9f871"), padding=10, fmt = "%.3f")
np.vlines(9.5, -0.27, 2.5, color="black", linestyles="dashed")
ax.bar_label(ax.bar(10, 0.3626, 0.8, color="#f9f871"), padding=10, fmt = "%.3f")
ax.bar_label(ax.bar(11, 2.4607, 0.8, color="turquoise"), padding=10, fmt = "%.3f")
ax.bar_label(ax.bar(12, 2.1906, 0.8, color="green"), padding=10, fmt = "%.3f")

ax.set_xticks(plt.arange(len(feedbacks)) + 1, feedbacks)
ax.tick_params(axis="x", labelsize=16)
ax.set_yticks(plt.arange(-0.25, 2.75, 0.25))
np.ylabel(r"$\Delta T$ in K", fontsize="xx-large")

np.savefig("img/balkendiagrammgeneratorpythonskriptdingskramsoutputdatei.svg", bbox_inches = "tight")

