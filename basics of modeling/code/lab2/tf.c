#include <stdio.h>
#include <math.h>
#include <Python.h>


 /******************************************************************************

 Дифференциальное уравнение Томаса–Ферми может быть представлено
 в виде системы двух уравнений первого порядка:

 f' = der_f(x,f,g)
 g' = der_g(x,f,g)

 ******************************************************************************/

double der_f( double x, double f, double g )
{
    return g;
}

double der_g( double x, double f, double g )
{
    return pow(sqrt(f), 3) / sqrt(x);
}


 /******************************************************************************

 Метод Рунге–Кутты четвертого порядка точности возвращает массив значений
 функции, соответствующих значениям из массива аргумента X

 ******************************************************************************/

int rk4( int n, double x_list[], double f_list[], double g_list[] )
{
    double x;
    double f = f_list[0];
    double g = g_list[0];
    double m1, n1, m2, n2, m3, n3, m4, n4, step;
    int i;
    for(i = 0; i < n - 1; ++i)
    {
        step = x_list[i+1] - x_list[i];
        x = x_list[i];

        m1 = der_f(x, f, g) * step;
        n1 = der_g(x, f, g) * step;

        m2 = der_f(x + step / 2, fmax(f + m1 / 2, 0.0), g + n1 / 2) * step;
        n2 = der_g(x + step / 2, fmax(f + m1 / 2, 0.0), g + n1 / 2) * step;

        m3 = der_f(x + step / 2, fmax(f + m2 / 2, 0.0), g + n2 / 2) * step;
        n3 = der_g(x + step / 2, fmax(f + m2 / 2, 0.0), g + n2 / 2) * step;

        m4 = der_f(x + step, fmax(f + m3, 0.0), g + n3) * step;
        n4 = der_g(x + step, fmax(f + m3, 0.0), g + n3) * step;

        f += (m1 + 2 * m2 + 2 * m3 + m4) / 6;
        g += (n1 + 2 * n2 + 2 * n3 + n4) / 6;

        f_list[i+1] = f;
        g_list[i+1] = g;

        if (f < 0)
            return 1;
    }
    return 0;
}

static PyObject *tf(PyObject *self, PyObject *args)
{
    double xmax;
    int steps_count;
    int i;
    // начальное условие:
    double x0 = 1e-6;
    // начальное условие для функции и её производной определяются
    // из её разложения в ряд в окрестности нуля
    double y0 = 1 - 1.58*x0 + 4/3 * pow(sqrt(x0), 3);
    double der_y0 = -1.58 + 2 * sqrt(x0);
    double eps_left = -1;
    double eps_right = 1;
    double eps;
    double *x_list, *f_list, *g_list;
    PyObject *xlst, *flst, *glst;

    if (!PyArg_ParseTuple(args, "di", &xmax, &steps_count))
        return NULL;

    x_list = calloc(sizeof(double), steps_count);
    f_list = calloc(sizeof(double), steps_count);
    g_list = calloc(sizeof(double), steps_count);
    for (i = 0; i < steps_count; ++i)
        x_list[i] = x0 + (xmax - x0) * i / (steps_count - 1);


    /**************************************************************************

    для определения начального условия на производную с большей точностью
    воспользуемся бинарным поиском:

     * если решение не ушло в отрицательную область, то поправку увеличиваем,
     * если же решение ушло в отрицательную область, то поправку уменьшаем

    **************************************************************************/

    while ((eps_right - eps_left) >= 1e-10)
    {
        eps = (eps_left + eps_right) / 2.0;
        f_list[0] = y0;
        g_list[0] = der_y0 - eps;
        if (!rk4(steps_count, x_list, f_list, g_list))
        {
            eps_left = eps;
        }
        else
        {
            eps_right = eps;
        }
    }

    xlst = PyList_New(steps_count);
    if (!xlst)
        return NULL;

    glst = PyList_New(steps_count);
    if (!glst)
        return NULL;

    flst = PyList_New(steps_count);
    if (!flst)
        return NULL;

    for (i = 0; i < steps_count; i++) {
        PyObject *x = PyFloat_FromDouble(x_list[i]);
        PyObject *g = PyFloat_FromDouble(g_list[i]);
        PyObject *f = PyFloat_FromDouble(f_list[i]);
        if (!x || !f || !g) {
            Py_DECREF(xlst);
            Py_DECREF(glst);
            Py_DECREF(flst);
            return NULL;
        }
        PyList_SET_ITEM(xlst, i, x);
        PyList_SET_ITEM(glst, i, g);
        PyList_SET_ITEM(flst, i, f);
    }

    free(x_list);
    free(f_list);
    free(g_list);

    return Py_BuildValue("[O, O, O]", xlst, flst, glst);
}

static PyMethodDef module_methods[] = {
    {"tf", tf, METH_VARARGS, NULL},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef module = {
   PyModuleDef_HEAD_INIT,
   "tf",   /* name of module */
   NULL, /* module documentation, may be NULL */
   -1,       /* size of per-interpreter state of the module,
                or -1 if the module keeps state in global variables. */
   module_methods
};

PyMODINIT_FUNC
PyInit_tf(void)
{
    return PyModule_Create(&module);
}
