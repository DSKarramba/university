import os
import sys
import re


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
    dest = student.split("~")[0]
    os.system("mkdir %s/lab%d" % (dest, number))
    with open("pre/lab%d.tex" % number, "r") as f:
        if number == 1:
            pre = f.read() % student
        else:
            pre = f.read() % (symbol(z1), symbol(z2), student)
    with open("text/lab%d.tex" % number, "r") as f:
        text = re.sub("\\s+\\\\cite{\\w+}\\s+", "", f.read())
    with open("post/lab%d.tex" % number, "r") as f:
        post = f.read()
    tex = pre + text + post
    with open("%s/lab%d/lab%d.tex" % (dest, number, number), "w") as f:
        f.write(tex)
    if os.path.exists("code/lab%d" % number):
        os.system("cp -r code/lab%d %s/lab%d/code" % (number, dest, number))
        if not os.path.exists("%s/lab%d/plots" % (dest, number)):
            os.system("mkdir %s/lab%d/plots" % (dest, number))
            os.system("make -C %s/lab%d/code PYTHON=%s Z1=%d Z2=%d" %
                      (dest, number, sys.executable, z1, z2))


def make_work(student, student_full, z1, z2):
    dest = student.split("~")[0]
    os.system("mkdir %s/work" % dest)
    with open("pre/work.tex", "r") as f:
        pre = f.read() % (z1, z2, symbol(z1), symbol(z2),
                          student, student_full)
    text = ""
    with open("text/lab1.tex", "r") as f:
        text += "\\section{Системы единиц измерения}\n"
        text += re.sub("section", "subsection", f.read())
    with open("text/lab2.tex", "r") as f:
        text += "\\newpage\n\\section{Атом Томаса--Ферми}\n"
        text += re.sub("section", "subsection", f.read())
    with open("text/lab3.tex", "r") as f:
        text += "\\clearpage\n\
                 \\section{Сечение упругого рассеяния в борновском\
                  приближении}\n"
        text += re.sub("section", "subsection", f.read())
    with open("post/work.tex", "r") as f:
        post = f.read()
    tex = pre + text + post
    with open("%s/work/work.tex" % dest, "w") as f:
        f.write(tex)

    os.system("mkdir %s/work/plots" % dest)
    os.system("mkdir %s/work/code" % dest)
    for i in range(1, 4):
        if os.path.exists("%s/lab%d/plots" % (dest, i)):
            os.system("cp %s/lab%d/plots/* %s/work/plots" % (dest, i, dest))
        if os.path.exists("%s/lab%d/code" % (dest, i)):
            os.system("cp %s/lab%d/code/{lab*.py,*.c} %s/work/code" %
                      (dest, i, dest))


def usage():
    print("Пример использования:")
    print("python3 deploy.py Фамилия Имя Отчество z1 z2")


if __name__ == '__main__':
    if (len(sys.argv) != 6):
        usage()
    else:
        dest = sys.argv[1]
        if not os.path.exists(dest):
            os.mkdir(dest)
        student_full = "~".join(sys.argv[1:4])
        student = "~".join([sys.argv[1],
                           sys.argv[2][0] + ".",
                           sys.argv[3][0] + "."])
        z1, z2, = map(int, sys.argv[4:])
        make_lab(1, student, z1, z2)
        make_lab(2, student, z1, z2)
        make_lab(3, student, z1, z2)
        make_work(student, student_full, z1, z2)
