#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <omp.h>

typedef double* Vector;
typedef double** Matrix;

const int m = 3;
int n;
int k;
double h;
double x;
int xk;
double eps;
int size;

Vector set(Vector b, int rows) {
  Vector c = new double[rows];
  for (int i = 0; i < rows; i++)
    c[i] = b[i];
  return c;
}

Vector mul(Matrix a, Vector b, int rows, int cols) {
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++)
      c[i] += a[i][j] * b[j];
  }
  return c;
}

Matrix mul(Matrix a, double b, int rows, int cols) {
  Matrix c = new Vector[rows];
  for (int i = 0; i < n; i++)
    c[i] = new double[cols];

  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++)
      c[i][j] = a[i][j] * b;
  }
  return c;
}

Vector mul(Vector a, double b, int rows) {
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++)
    c[i] = a[i] * b;
  return c;
}

Vector sum(Vector a, Vector b, int rows) {
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++)
    c[i] = a[i] + b[i];
  return c;
}

Vector sub(Vector a, Vector b, int rows) {
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++)
    c[i] = a[i] - b[i];
  return c;
}

void set_data(Matrix& a, Vector& y0, Matrix& f) {
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++)
      a[i][j] = (double)rand() / (RAND_MAX) * 2 - 1;
  }

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++)
      f[i][j] = (double)rand() / (RAND_MAX) * 2 - 1;
  }
  
  for (int i = 0; i < n; i++)
    y0[i] = (double)rand() / (RAND_MAX) * 2 - 1;
}

Vector f_t(Matrix f, double t, int rows) {
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++)
    c[i] = exp(-t) * cos(log(f[i][0] * f[i][0])) +
      sin(f[i][1]) * tan(t) + exp(-abs(f[i][2]));
  return c;
}

Vector runge_kutta(Matrix a, Vector y, Matrix f) {
  Vector k1 = new double[n];
  Vector k2 = new double[n];
  Vector k3 = new double[n];
  Vector k4 = new double[n];
  Vector temp = new double[n];
  
  k1 = sum(mul(mul(a, y, n, n), h, n), mul(f_t(f, x, n), h, n), n);
  k2 = sum(mul(mul(a, sum(y, mul(k1, 0.5, n), n), n, n), h, n),
    mul(f_t(f, x + h / 2, n), h, n), n);
  k3 = sum(mul(mul(a, sum(y, mul(k2, 0.5, n), n), n, n), h, n),
    mul(f_t(f, x + h / 2, n), h, n), n);
  k4 = sum(mul(mul(a, sum(y, k3, n), n, n), h, n),
    mul(f_t(f, x + h, n), h, n), n);
  
  temp = sum(y, mul(sum(sum(k1, k4, n),
    mul(sum(k2, k3, n), 2.0, n), n), 1.0 / 6, n), n);
  return temp;
}

Vector v(Matrix a, Vector y, Matrix f, double t, int rows, int cols) {
  Vector temp = new double[n];
  temp = sum(mul(a, y, rows, cols), f_t(f, t, rows), rows);
  return temp;
}

double norm(Vector a, int rows) {
  double temp = 0;
  
  for (int i = 0; i < rows; i++)
    temp += a[i] * a[i];
  return sqrt(temp);
}

int main() {
  printf("Input number of threads: ");
  scanf("%d", &size);
  omp_set_num_threads(size);
  printf("Input number of equations: ");
  scanf("%d", &n);
  printf("Input step: ");
  scanf("%lf", &h);
  eps = h / 100.0;
  printf("Input number of points: ");
  scanf("%d", &xk);
  k = n / size;
  double start, finish;
  
  x = 0;
  
  Matrix a = new Vector[n];
  for (int i = 0; i < n; i++)
    a[i] = new double[n];
  Matrix f0 = new Vector[n];
  for (int i = 0; i < n; i++)
    f0[i] = new double[m];
    
  Vector y0 = new double[n];
  set_data(a, y0, f0);  
  Vector y1 = new double[n];
  y1 = runge_kutta(a, y0, f0);
  x += h;
  Vector y2 = new double[n];
  y2 = runge_kutta(a, y1, f0);
  x += h;
  Vector y = new double[n];
  y = runge_kutta(a, y2, f0);
  x += h;
  
#pragma omp parallel shared (y)
{
  Matrix b = new Vector[k];
  for (int i = 0; i < k; i++)
    b[i] = new double[n];
  Matrix f = new Vector[k];
  for (int i = 0; i < k; i++)
    f[i] = new double[m];

  int rank = omp_get_thread_num();
  for (int i = rank * k; i < (rank + 1) * k; i++) {
    b[i - rank * k] = set(a[i], n);
    f[i - rank * k] = set(f0[i], n);
  }
  
  Vector v3 = new double[k]; 
  Vector v2 = new double[k]; 
  Vector v1 = new double[k]; 
  Vector v0 = new double[k]; 
  Vector yp = new double[k];
  Vector yc = new double[k];
  Vector vn = new double[k];
  double norma;

#pragma omp master
{  
  start = omp_get_wtime();
}
  
  v3 = v(b, y,  f, x, k, n);
  v2 = v(b, y2, f, x - h, k, n);
  v1 = v(b, y1, f, x - 2 * h, k, n);
  v0 = v(b, y0, f, x - 3 * h, k, n);
  
  while (x < xk * h) {
    norma = 100.0 * eps;
    
    yp = sum(y, mul(sum(sub(mul(v3, 55.0, k), mul(v2, 59.0, k), k),
      sub(mul(v1, 37.0, k), mul(v0, 9.0, k), k), k), h / 24, k), k);
    
    x += h;
    
    while (norma > eps) {
      vn = v(b, yp, f, x, k, n);  
      yc = sum(y0, mul(sum(sum(mul(vn, 9.0, k), mul(v3, 19.0, k), k),
        sub(mul(v2, 5.0, k), v1, k), k), h / 24, k), k);
      norma = norm(sub(yc, yp, k), k);
      yp = set(yc, k);
    }
    
    v0 = set(v1, k);
    v1 = set(v2, k);
    v2 = set(v3, k);
    int rank = omp_get_thread_num();
#pragma omp barrier
    for (int i = rank * k; i < (rank + 1) * k; i++)
      y[i] = yp[i - rank * k];
    v3 = set(v(b, y, f, x, k, n), k);
  }
  
#pragma omp master
{
  finish = omp_get_wtime();
  double time = finish - start;
  
  printf("Elapsed time: %.3lf\n", time);
}
}  
  return 0;
}
