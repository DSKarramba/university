#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctime>

typedef double* Vector;
typedef double** Matrix;

const int m = 3;
int n;
double h;
double x;
int xk;
double eps;

void set(Vector& a, Vector b) {
  int rows = n;
  
  for (int i = 0; i < rows; i++)
    a[i] = b[i];
}

Vector mul(Matrix a, Vector b) {
  int rows = n;
  int cols = n;
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++)
      c[i] += a[i][j] * b[j];
  }
  return c;
}

Matrix mul(Matrix a, double b) {
  int rows = n;
  int cols = n;
  Matrix c = new Vector[rows];
  for (int i = 0; i < n; i++)
    c[i] = new double[cols];
  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++)
      c[i][j] = a[i][j] * b;
  }
  return c;
}

Vector mul(Vector a, double b) {
  int rows = n;
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++) {
    c[i] = a[i] * b;
  }
  return c;
}

Vector sum(Vector a, Vector b) {
  int rows = n;
  Vector c = new double[rows];
  
  for (int i = 0; i < rows; i++)
    c[i] = a[i] + b[i];
  return c;
}

Vector sub(Vector a, Vector b) {
  int rows = n;
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

Vector f_t(Matrix f, double t) {
  int rows = n;
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
  
  k1 = sum(mul(mul(a, y), h), mul(f_t(f, x), h));
  k2 = sum(mul(mul(a, sum(y, mul(k1, 0.5))), h),
    mul(f_t(f, x + h / 2), h));
  k3 = sum(mul(mul(a, sum(y, mul(k2, 0.5))), h),
    mul(f_t(f, x + h / 2), h));
  k4 = sum(mul(mul(a, sum(y, k3)), h),
    mul(f_t(f, x + h), h));
  
  temp = sum(y, mul(sum(sum(k1, k4), mul(sum(k2, k3), 2)), 1.0 / 6));
  return temp;
}

Vector v(Matrix a, Vector y, Matrix f, double t) {
  Vector temp = new double[n];
  temp = sum(mul(a, y), f_t(f, t));
  return temp;
}

double norm(Vector a) {
  int rows = n;
  double temp = 0;
  
  for (int i = 0; i < rows; i++)
    temp += a[i] * a[i];
  return sqrt(temp);
}

Vector adams(Vector yn, Vector yn1, Vector yn2, Vector yn3,
  Matrix a, Matrix f) {
  Vector v3 = new double[n]; v3 = v(a, yn,  f, x);
  Vector v2 = new double[n]; v2 = v(a, yn1, f, x - h);
  Vector v1 = new double[n]; v1 = v(a, yn2, f, x - 2 * h);
  Vector v0 = new double[n]; v0 = v(a, yn3, f, x - 3 * h);
  
  Vector yp = new double[n];
  Vector yc = new double[n];
  Vector vn = new double[n];
  double norma;
  
  while (x < xk * h) {
    norma = 100.0 * eps;
    
    yp = sum(yn, mul(sum(sub(mul(v3, 55.0), mul(v2, 59.0)),
      sub(mul(v1, 37.0), mul(v0, 9.0))), h / 24));
    
    x += h;
    
    while (norma > eps) {
      vn = v(a, yp, f, x);  
      yc = sum(yn, mul(sum(sum(mul(vn, 9.0), mul(v3, 19.0)),
        sub(mul(v2, 5.0), v1)), h / 24));
      norma = norm(sub(yc, yp));
      set(yp, yc);
    }
    
    set(yn, yc);
    set(v0, v1);
    set(v1, v2);
    set(v2, v3);
    set(v3, v(a, yn, f, x));
  }
  return yn;
}

int main() {
  printf("Input number of equations: ");
  scanf("%d", &n);
  printf("Input step: ");
  scanf("%lf", &h);
  eps = h / 100.0;
  printf("Input number of points: ");
  scanf("%d", &xk);
  clock_t start, finish;
  
  x = 0;
  
  Matrix a = new Vector[n];
  for (int i = 0; i < n; i++)
    a[i] = new double[n];
  Matrix f = new Vector[n];
  for (int i = 0; i < n; i++)
    f[i] = new double[m];
    
  Vector y0 = new double[n];
  set_data(a, y0, f);
  
  Vector y = new double[n];
  set(y, y0);
  
  Vector y1 = new double[n]; y1 = runge_kutta(a, y, f);
  x += h;
  Vector y2 = new double[n]; y2 = runge_kutta(a, y1, f);
  x += h;
  y = runge_kutta(a, y2, f);
  x += h;
  
  start = clock();
  y = adams(y, y2, y1, y0, a, f);
  finish = clock();
  double time = (double)(finish - start) / (double) CLOCKS_PER_SEC;
  
  printf("Elapsed time: %.3lf\n", time);
  
  return 0;
}
