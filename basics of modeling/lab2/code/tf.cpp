#include <cstdio>
#include <cmath>
#include <vector>

#define forn(i, n) for ( size_t i = 0; i < n; i++ )

typedef std::vector<double> vd;


/******************************************************************************

Дифференциальное уравнение Томаса - Ферми может быть представлено
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

Метод Рунге - Кутты 4 - го порядка точности
возвращает массив значений функции, соответствующих значениям из
массива аргумента X

******************************************************************************/
vd rk4( vd X, double f0, double g0 )
{
    vd F;

    double f = f0;
    double g = g0;
    double x = X[0];

    F.push_back(f);

    double m1, n1, m2, n2, m3, n3, m4, n4, step;
    forn(i, X.size() - 1)
    {
        step = X[i+1] - X[i];
        x = X[i];

        m1 = der_f(x, f, g) * step;
        n1 = der_g(x, f, g) * step;

        m2 = der_f(x + step / 2, std::max(f + m1 / 2, 0.0), g + n1 / 2) * step;
        n2 = der_g(x + step / 2, std::max(f + m1 / 2, 0.0), g + n1 / 2) * step;

        m3 = der_f(x + step / 2, std::max(f + m2 / 2, 0.0), g + n2 / 2) * step;
        n3 = der_g(x + step / 2, std::max(f + m2 / 2, 0.0), g + n2 / 2) * step;

        m4 = der_f(x + step, std::max(f + m3, 0.0), g + n3) * step;
        n4 = der_g(x + step, std::max(f + m3, 0.0), g + n3) * step;

        f += (m1 + 2 * m2 + 2 * m3 + m4) / 6;
        g += (n1 + 2 * n2 + 2 * n3 + n4) / 6;

        F.push_back(f);
        if (f < 0 || f > 1)
            break;
    }
    return F;
}

int main(int argc, const char *argv[])
{
    // начальное условие:
    double x0 = 1e-6;
    // начальное условие для функции и её производной определяются
    // из её разложения в ряд в окрестности нуля
    double y0 = 1 - 1.58*x0 + 4/3 * pow(sqrt(x0), 3);
    double der_y0 = -1.58 + 2 * sqrt(x0);

    vd X;
    double xmax = 60;
    size_t len = 100000;
    forn(i, len)
    {
        X.push_back(x0 + (xmax - x0) * i / (len - 1));
    }

    vd F;

    /**************************************************************************

    для определения начального условия на производную с большей точностью
    воспользуемся бинарным поиском:

     * если решение не разошлось или превысило 1, то поправку увеличиваем,
     * если же решение ушло в отрицательную область, то поправку уменьшаем

    **************************************************************************/
    double eps_left = 0;
    double eps_right = 1;
    double eps;
    while ((eps_right - eps_left) >= 1e-10)
    {
        eps = (eps_left + eps_right) / 2.0;
        F = rk4(X, y0, der_y0 - eps);
        if (F.size() == X.size() || F[F.size()-1] > 1)
            eps_left = eps;
        else
            eps_right = eps;
    }

    // выводим результаты численного интегрирования в файл
    FILE *file;
    file = fopen("data.py", "w");
    fprintf(file, "x0 = %f; y0 = %f; der_y0 = %f\n", x0, y0, der_y0 - eps);
    fprintf(file, "X = [ ");
    forn(i, F.size())
        fprintf(file, "%f, ", X[i]);
    fprintf(file, "]\n");
    fprintf(file, "F = [ ");
    forn(i, F.size())
        fprintf(file, "%f, ", F[i]);
    fprintf(file, "]\n");
    fclose(file);
    return 0;
}
