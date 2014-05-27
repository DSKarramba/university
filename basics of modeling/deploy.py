import os
import sys


def symbol(z):
    table = ["H", "He",
             "Li", "Be", "B", "C", "N", "O", "F", "Ne",
             "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar",
             "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni",
             "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr",
             "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd",
             "Ag", "Cd", "In", "Sn"]
    return table[z-1]


def make_lab(number, student, z1, z2):
    os.system("mkdir test/lab%d" % number)
    with open("pre/lab%d.tex" % number, "r") as f:
        if number == 1:
            pre = f.read() % student
        else:
            pre = f.read() % (symbol(z1), symbol(z2), student)
    with open("text/lab%d.tex" % number, "r") as f:
        text = f.read()
    with open("post/lab.tex", "r") as f:
        post = f.read()
    tex = pre + text + post
    with open("test/lab%d/lab%d.tex" % (number, number), "w") as f:
        f.write(tex)
    if os.path.exists("code/lab%d" % number):
        os.system("mkdir test/lab%d/plots" % number)
        os.system("cp -r code/lab%d test/lab%d/code" % (number, number))
        os.system("make -C test/lab%d/code PYTHON=%s Z1=%d Z2=%d" %\
                  (number, sys.executable, z1, z2))


def make_work():
    pass


def usage():
    print("./deploy.py Фамилия И. О. z1 z2")


if __name__ == '__main__':
    if os.path.exists("test"):
        os.system("rm -rf test")
    os.mkdir("test")
    student = "~".join(sys.argv[1:4])
    z1, z2, = map(int, sys.argv[4:])
    make_lab(1, student, z1, z2)
    make_lab(2, student, z1, z2)
    make_lab(3, student, z1, z2)
