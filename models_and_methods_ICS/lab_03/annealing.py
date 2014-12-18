from __future__ import division
from random import random
import numpy as np

def func(x, y):
  return x ** 2 + 5 * abs(x) / np.sqrt(abs(x) + 0.1) + \
   abs(x - 0.2) / np.sqrt(abs(x - 0.2) + 0.01) + \
   abs(x + 0.2) / np.sqrt(abs(x + 0.2) + 0.01) \
   + y ** 2

r = float(raw_input('Input R: '))
t = float(raw_input('Input T: '))
n = int(raw_input('Input N: '))

x0 = (random() - 0.5) * r
y0 = (random() - 0.5) * r
f0 = func(x0, y0)

fl = [f0]
xl = [x0]

for i in range(n):
  x = (random() - 0.5) * r + x0
  y = (random() - 0.5) * r + y0
  f = func(x, y)
  if f < f0:
    x0, y0, f0 = x, y, f
  else:
    if f - f0 < 0:
      p = 1
    else:
      p = np.exp(-(f - f0) / t)
    if random() < p:
      #print '  jump from {1:.5f} to {0:.5f}'.format(f, f0)
      x0, y0, f0 = x, y, f
  r -= r / n
  t -= t / n
  xl.append(x0)
  fl.append(f0)

print x0, y0, f0
