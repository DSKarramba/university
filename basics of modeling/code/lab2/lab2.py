from matplotlib import pyplot as plt
from numpy import linspace
from math import pi, e
from tf import tf
from sys import argv

plt.rc("text", usetex=True)
plt.rc("font", family="serif", size=10)
plt.rc("text.latex", unicode=True)
plt.rc("text.latex", preamble="\\usepackage[utf8x]{inputenc}\
                           \\usepackage[T2A]{fontenc}\
                           \\usepackage[russian]{babel}\
                           \\usepackage{amsmath}")

a0 = 5.292e-9
b = (3 * pi) ** (2 / 3) / 2 ** (7 / 3)
q = 4.8e-10
X, F, G = tf(60, 10000)

def plot_phi():
    n = len(F) // 100 + 1
    p1, = plt.plot(X[::n], F[::n])

    DAU = [
        (0.00, 1.00000),
        (0.02, 0.97200),
        (0.04, 0.94700),
        (0.06, 0.92400),
        (0.08, 0.90200),
        (0.10, 0.88200),
        (0.20, 0.79300),
        (0.30, 0.72100),
        (0.40, 0.66000),
        (0.50, 0.60700),
        (0.60, 0.56100),
        (0.70, 0.52100),
        (0.80, 0.48500),
        (0.90, 0.45300),
        (1.00, 0.42400),
        (1.20, 0.37400),
        (1.40, 0.33300),
        (1.60, 0.29800),
        (1.80, 0.26800),
        (2.00, 0.24300),
        (2.20, 0.22100),
        (2.40, 0.20200),
        (2.60, 0.18500),
        (2.80, 0.17000),
        (3.00, 0.15700),
        (3.20, 0.14500),
        (3.40, 0.13400),
        (3.60, 0.12500),
        (3.80, 0.11600),
        (4.00, 0.10800),
        (4.50, 0.09190),
        (5.00, 0.07880),
        (6.00, 0.05940),
        (7.00, 0.04610),
        (8.00, 0.03660),
        (9.00, 0.02960),
        (10.0, 0.02430),
        (11.0, 0.02020),
        (12.0, 0.01710),
        (13.0, 0.01450),
        (14.0, 0.01250),
        (15.0, 0.01080),
        (20.0, 0.00580),
        (25.0, 0.00350),
        (30.0, 0.00230),
        (40.0, 0.00110),
        (50.0, 0.00063),
        (60.0, 0.00039)
    ]
    X_exp, F_exp = zip(*DAU)
    p2, = plt.plot(X_exp, F_exp, "k+")

    X_mol = linspace(0, 60, 101)
    beta = [.6, 1.2, .3]
    B = [.1, .55, .35]
    f = lambda x: sum(
        [x * y for x, y in zip(B, map(lambda t: e**(-t * x / b), beta))])
    F_mol = list(map(f, X_mol))
    p3, = plt.plot(X_mol, F_mol, "r-")

    plt.legend([p1, p2, p3],
        ["Численный расчёт", "Результаты Ландау", "Аппроксимация Мольер"])
    plt.xlabel("\( x \)")
    plt.ylabel("\( \Phi \)")
    plt.savefig("common.pdf")
    plt.cla()

def plot_potential(Z):
    R = list(map(lambda x: x * b * a0 / Z ** (1 / 3), X))
    U = [-Z * q / R[i] * f for i, f in enumerate(F)]
    R_w = list(filter(lambda x: 2e-9 < x < 1e-8, R))
    i = R.index(R_w[0])
    j = R.index(R_w[-1])
    U_w = U[i:j+1]
    n = len(R_w) // 100 + 1;
    p, = plt.plot(R_w[::n], U_w[::n])
    plt.xlim(0, 1.1e-8)
    plt.xlabel(r"\( r,~\text{см} \)")
    plt.ylabel(r"\( U,~\text{эВ} \)")
    return p

if __name__ == '__main__':
    plot_phi()
    Z_list = list(map(int, argv[1:]))
    lines = [plot_potential(Z) for Z in Z_list]
    labels = ["Z = %d" % Z for Z in Z_list]
    plt.legend(lines, labels, loc=4)
    plt.savefig("Z_" + "_".join(argv[1:]) + ".pdf")
