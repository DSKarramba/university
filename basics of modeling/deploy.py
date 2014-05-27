import os
import sys

def make_lab(number, student, z1, z2):
    os.system("mkdir test/lab%d" % number)
    with open("pre/lab%d.tex" % number, "r") as f:
        pre = f.read() % student
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
