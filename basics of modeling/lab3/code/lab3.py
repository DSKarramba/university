from numpy import cos, pi, linspace, exp, arange
from scipy.integrate import quad
from matplotlib import pyplot as plt
import sys

plt.rc("text", usetex=True)
plt.rc("font", family="serif", size=10)
plt.rc("text.latex", unicode=True)
plt.rc("text.latex", preamble="\\usepackage[utf8x]{inputenc}\
                           \\usepackage[T2A]{fontenc}\
                           \\usepackage[russian]{babel}\
                           \\usepackage{amsmath}\
                           \\usepackage{pscyr}")


def salvat_coeff(Z):
    data = [
        [-184.39, 185.39, 2.0027, 1.9973, 0],
        [-0.2259, 1.2259, 5.5272, 2.3992, 0],
        [0.6045, 0.3955, 2.8174, 0.6625, 0],
        [0.3278, 0.6722, 4.5430, 0.9852, 0],
        [0.2327, 0.7673, 5.9900, 1.2135, 0],
        [0.1537, 0.8463, 8.0404, 1.4913, 0],
        [0.0996, 0.9004, 10.812, 1.7687, 0],
        [0.0625, 0.9375, 14.823, 2.0403, 0],
        [0.0368, 0.9632, 21.400, 2.3060, 0],
        [0.0188, 0.9812, 34.999, 2.5662, 0],
        [0.7444, 0.2556, 4.1205, 0.8718, 0],
        [0.6423, 0.3577, 4.7266, 1.0025, 0],
        [0.6002, 0.3998, 5.1405, 1.0153, 0],
        [0.5160, 0.4840, 5.8492, 1.1732, 0],
        [0.4387, 0.5613, 6.6707, 1.3410, 0],
        [0.5459, -0.5333, 6.3703, 2.5517, 1.6753],
        [0.7249, -0.7548, 6.2118, 3.3883, 1.8596],
        [2.1912, -2.2852, 5.5470, 4.5687, 2.0446],
        [0.0486, 0.7759, 30.260, 3.1243, 0.7326],
        [0.5800, 0.4200, 6.3218, 1.0094, 0],
        [0.5543, 0.4457, 6.6328, 1.1023, 0],
        [0.0112, 0.6832, 99.757, 4.1286, 1.0090],
        [0.0318, 0.6753, 42.533, 3.9404, 1.0533],
        [0.1075, 0.7162, 18.959, 3.0638, 1.0014],
        [0.0498, 0.6866, 31.864, 3.7811, 1.1279],
        [0.0512, 0.6995, 31.825, 3.7716, 1.1606],
        [0.0500, 0.7142, 32.915, 3.7908, 1.1915],
        [0.0474, 0.7294, 34.758, 3.8299, 1.2209],
        [0.0771, 0.7951, 25.326, 3.3928, 1.1426],
        [0.0400, 0.7590, 40.343, 3.9465, 1.2759],
        [0.1083, 0.7489, 20.192, 3.4733, 1.0064],
        [0.0610, 0.7157, 29.200, 4.1252, 1.1845],
        [0.0212, 0.6709, 62.487, 4.9502, 1.3582],
        [0.4836, 0.5164, 8.7824, 1.6967, 0],
        [0.4504, 0.5496, 9.3348, 1.7900, 0],
        [0.4190, 0.5810, 9.9142, 1.8835, 0],
        [0.1734, 0.7253, 17.166, 3.1103, 0.7177],
        [0.0336, 0.7816, 55.208, 4.2842, 0.8578],
        [0.0689, 0.7202, 31.366, 4.2412, 0.9472],
        [0.1176, 0.6581, 22.054, 4.0325, 1.0181],
        [0.2257, 0.5821, 14.240, 2.9702, 1.0170],
        [0.2693, 0.5763, 14.044, 2.8611, 1.0591],
        [0.2201, 0.5618, 15.918, 3.3672, 1.1548],
        [0.2751, 0.5943, 14.314, 2.7370, 1.1092],
        [0.2711, 0.6119, 14.654, 2.7183, 1.1234],
        [0.2784, 0.6067, 14.645, 2.6155, 1.4318],
        [0.2562, 0.6505, 15.588, 2.7412, 1.1408],
        [0.2271, 0.6155, 16.914, 3.0841, 1.2619],
        [0.2492, 0.6440, 16.155, 2.8819, 0.9942],
        [0.2153, 0.6115, 17.793, 3.2937, 1.1478],
        [0.1806, 0.5767, 19.875, 3.8092, 1.2829],
        [0.1308, 0.5504, 24.154, 4.6119, 1.4195],
        [0.0588, 0.5482, 39.996, 5.9132, 1.5471],
        [0.4451, 0.5549, 11.805, 1.7967, 0],
        [0.2708, 0.6524, 16.591, 2.6964, 0.6814],
        [0.1728, 0.6845, 22.397, 3.4595, 0.8073],
        [0.1947, 0.6384, 20.764, 3.4657, 0.8911],
        [0.1913, 0.6467, 21.235, 3.4819, 0.9011],
        [0.1868, 0.6558, 21.803, 3.5098, 0.9106],
        [0.1665, 0.7057, 23.949, 3.5199, 0.8486],
        [0.1624, 0.7133, 24.598, 3.5560, 0.8569],
        [0.1580, 0.7210, 25.297, 3.5963, 0.8650],
        [0.1538, 0.7284, 26.017, 3.6383, 0.8731],
        [0.1587, 0.7024, 25.497, 3.7364, 0.9550],
        [0.1453, 0.7426, 27.547, 3.7288, 0.8890],
        [0.1413, 0.7494, 28.346, 3.7763, 0.8969],
        [0.1374, 0.7558, 29.160, 3.8244, 0.9048],
        [0.1336, 0.7619, 29.990, 3.8734, 0.9128],
        [0.1299, 0.7680, 30.835, 3.9233, 0.9203],
        [0.1267, 0.7734, 31.681, 3.9727, 0.9288],
        [0.1288, 0.7528, 31.353, 4.0904, 1.0072],
        [0.1303, 0.7324, 31.217, 4.2049, 1.0946],
        [0.1384, 0.7096, 30.077, 4.2492, 1.1697],
        [0.1500, 0.6871, 28.630, 4.2426, 1.2340],
        [0.1608, 0.6659, 27.568, 4.2341, 1.2970],
        [0.1722, 0.6468, 26.586, 4.1999, 1.3535],
        [0.1834, 0.6306, 25.734, 4.1462, 1.4037],
        [0.2230, 0.6176, 22.994, 3.7346, 1.4428],
        [0.2289, 0.6114, 22.864, 3.6914, 1.4886],
        [0.2098, 0.6004, 24.408, 3.9643, 1.5343],
        [0.2708, 0.6428, 20.941, 3.2456, 1.1121],
        [0.2380, 0.6308, 22.987, 3.6217, 1.2373],
        [0.2288, 0.6220, 23.792, 3.7796, 1.2534],
        [0.1941, 0.6105, 26.695, 4.2582, 1.3577],
        [0.1500, 0.6031, 31.840, 4.9285, 1.4683],
        [0.0955, 0.6060, 43.489, 5.8520, 1.5736],
        [0.3192, 0.6233, 20.015, 2.9091, 0.7207],
        [0.2404, 0.6567, 24.501, 3.5524, 0.8376],
        [0.2266, 0.6422, 25.684, 3.7922, 0.9335],
        [0.2176, 0.6240, 26.554, 4.0044, 1.0238],
        [0.2413, 0.6304, 25.193, 3.6780, 0.9699],
        [0.2448, 0.6298, 25.252, 3.6397, 0.9825]
    ]
    A = data[Z-1][:2] + [1-sum(data[Z-1][:2])]
    a = data[Z-1][2:]
    return A, a


# функции экранирования
def screen(A, a, r):
    return sum((A[i] * exp(-a[i] * r) for i in range(3)))


def mscreen(z):
    A = [.1, .55, .35]
    b = 0.88534 * z ** (-1/3)
    a = list(map(lambda x: x / b, [6, 1.2, .3]))
    return lambda r: screen(A, a, r)


def sscreen(z):
    A, a = salvat_coeff(z)
    return lambda r: screen(A, a, r)


# плотность
def density(A, a, z, r):
    return z*r*sum((A[i] * a[i] ** 2 * exp(-a[i] * r) for i in range(3)))


def mdensity(z):
    A = [.1, .55, .35]
    b = 0.88534 * z ** (-1/3)
    a = list(map(lambda x: x / b, [6, 1.2, .3]))
    return lambda r: density(A, a, z, r)


def sdensity(z):
    A, a = salvat_coeff(z)
    return lambda r: density(A, a, z, r)


# форм-фактор
def formfactor(A, a, z, r):
    # на самом деле, это F/Z
    result = 0
    for i in range(3):
        if a[i]:
            result += A[i] * a[i] ** 2 / (a[i] ** 2 + r ** 2)
    return result


def mformfactor(z):
    A = [.1, .55, .35]
    b = 0.88534 * z ** (-1/3)
    a = list(map(lambda x: x / b, [6, 1.2, .3]))
    return lambda r: formfactor(A, a, z, r)


def sformfactor(z):
    A, a = salvat_coeff(z)
    return lambda r: formfactor(A, a, z, r)


# дифференциальное сечение
def diffsect(z, ff):
    return lambda q: (2 * z / q ** 2 * (1 - ff(z)(q))) ** 2


# полное сечение
def prod_sect_energy(z, ff, k_list):
    integrand = lambda x: 4 * pi * z ** 2 * x ** -3 * (1 - ff(z)(x)) ** 2
    result = [0]
    for i in range(1, len(k_list)):
        result.append(result[-1] +
                      quad(integrand, 2 * k_list[i-1], 2 * k_list[i])[0])
    return result


def plot_screen(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    rlist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(rlist, mscreen(z)(rlist), c + "-", label="Мольер, Z = %d" % z)
        plt.plot(rlist, sscreen(z)(rlist), c + "--",
                 label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$r, \text{а. е.}$')
    plt.ylabel(r'$\text{Функция экранирования}$')
    plt.savefig("screening.pdf")


def plot_density(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    rlist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(rlist, mdensity(z)(rlist), c + "-",
                 label="Мольер, Z = %d" % z)
        plt.plot(rlist, sdensity(z)(rlist), c + "--",
                 label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$r, \text{а. е.}$')
    plt.ylabel(r'$\text{Плотность заряда, а. е.}$')
    plt.savefig("density.pdf")


def plot_r_density(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    rlist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(rlist, 4 * pi * rlist ** 2 * mdensity(z)(rlist), c + "-",
                 label="Мольер, Z = %d" % z)
        plt.plot(rlist, 4 * pi * rlist ** 2 * sdensity(z)(rlist), c + "--",
                 label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$r, \text{а. е.}$')
    plt.ylabel(r'$\text{Радиальная плотность заряда, а. е.}$')
    plt.savefig("radial_density.pdf")


def plot_ff(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    qlist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(qlist, mformfactor(z)(qlist), c + "-",
                 label="Мольер, Z = %d" % z)
        plt.plot(qlist, sformfactor(z)(qlist), c + "--",
                 label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$\text{Переданный импульс }q\text{, а. е.}$')
    plt.ylabel(r'$\text{Форм-фактор}$')
    plt.savefig("form-factor.pdf")


def plot_diffsect(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    qlist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(qlist, diffsect(z, mformfactor)(qlist), c + "-",
                 label="Мольер, Z = %d" % z)
        plt.plot(qlist, diffsect(z, sformfactor)(qlist), c + "--",
                 label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$\text{Переданный импульс }q\text{, а. е.}$')
    plt.ylabel(r'$\text{Дифференциальное сечение рассеяния}$')
    plt.savefig("diffsect.pdf")


def plot_sect(zlist):
    plt.cla()
    colors = ["r", "b", "g", "p", "k"]
    klist = arange(0, 10, 0.1)
    for c, z in zip(colors, zlist):
        plt.plot(klist ** 2 / 2, prod_sect_energy(z, mformfactor, klist),
                 c + "-", label="Мольер, Z = %d" % z)
        plt.plot(klist ** 2 / 2, prod_sect_energy(z, sformfactor, klist),
                 c + "--", label="Сальват, Z = %d" % z)
    plt.grid()
    plt.legend()
    plt.xlabel(r'$\text{Энергия налетающих электронов }E\text{, а. е.}$')
    plt.ylabel(r'$\sigma\cdot E$')
    plt.savefig("sect.pdf")


if __name__ == '__main__':
    zlist = list(map(int, sys.argv[1:]))
    plot_screen(zlist)
    plot_density(zlist)
    plot_r_density(zlist)
    plot_ff(zlist)
    plot_diffsect(zlist)
    plot_sect(zlist)
