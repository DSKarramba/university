from matplotlib import pyplot as plt
import numpy as np
from data import X, F, F1

PRODUCTION = True

if PRODUCTION:
    plt.rc("text", usetex=True)
    plt.rc("font", family="serif", size=14)
    plt.rc("text.latex", unicode=True)
    plt.rc("text.latex", preamble="\\usepackage[utf8x]{inputenc}\
                               \\usepackage[T2A]{fontenc}\
                               \\usepackage[russian]{babel}\
                               \\usepackage{amsmath}\
                               \\usepackage{pscyr}")


alpha = [.6, 1.2, .3]
A = [.1, .55, .35]


def moliere(r):
    return 1 - sum([A[i] * (1 + alpha[i] * r) * np.exp(-alpha[i] * r) for i
                    in range(3)])

plt.plot(X, list(map(moliere, X)), label="Moliere")
plt.plot(X,
         [X[i] * F1[i] - F[i] + 1 for i in range(len(X))],
         label="Thomas-Fermi")
plt.grid(True)
plt.legend(loc=4)
plt.savefig("charge_in_sphere.pdf")
