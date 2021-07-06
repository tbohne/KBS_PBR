#!/usr/bin/env python

import numpy as np

# approximating pi using Monte Carlo

target_hits = 0
darts = 1000000

for i in range(darts):
    # rand \in [0, 1]
    x = np.random.rand()
    y = np.random.rand()
    if np.sqrt(x ** 2 + y ** 2) < 1.0:
        target_hits += 1

pi = target_hits / darts * 4
print("approximated pi:", pi)