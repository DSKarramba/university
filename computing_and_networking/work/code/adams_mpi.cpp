#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>

/*
  внимание!
  во время работы возникает Segmentation Fault,
  причина не найдена
*/

typedef double* Vector;
typedef double** Matrix;

const int m = 3;
int n;
int k;
double h;
double x;
int xk;
double eps;
int size, rank;

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

void set_data(Matrix a, Vector y0, Matrix f) {
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

Vector runge_kutta(Matrix& a, Vector& y, Matrix& f) {
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

int main(int argc, char** argv) {
  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Status status;
  
  Vector y0 = new double[n];
  Vector y = new double[n];
  Vector y1 = new double[n];
  Vector y2 = new double[n];
  double start, finish;
    
  if (rank == 0) {    
    printf("Input number of equations: ");
    scanf("%d", &n);
    printf("Input step: ");
    scanf("%lf", &h);
    eps = h / 100.0;
    printf("Input number of points: ");
    scanf("%d", &xk);
    k = n / size;
  }
  
  MPI_Barrier(MPI_COMM_WORLD);
  MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(&h, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(&eps, 1, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(&xk, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(&k, 1, MPI_INT, 0, MPI_COMM_WORLD);
  
  x = 0;
  Matrix b = new Vector[n];
  for (int i = 0; i < k; i++)
    b[i] = new double[n];
  Matrix f = new Vector[n];
  for (int i = 0; i < k; i++)
    f[i] = new double[m];
  
  if (rank == 0) {  
    Matrix a = new Vector[n];
    for (int i = 0; i < n; i++)
      a[i] = new double[n];
    Matrix f0 = new Vector[n];
    for (int i = 0; i < n; i++)
      f0[i] = new double[m];
      
    set_data(a, y0, f0);
    y1 = runge_kutta(a, y0, f0);
    x += h;
    y2 = runge_kutta(a, y1, f0);
    x += h;
    y = runge_kutta(a, y2, f0);
    x += h;
    
    for (int i = 1; i < size; i++) {
      for (int j = i * k; j < (i + 1) * k; j++) {
        MPI_Send(a[j], n, MPI_DOUBLE, i, j, MPI_COMM_WORLD);
        MPI_Send(f0[j], m, MPI_DOUBLE, i, j, MPI_COMM_WORLD);
      }
    }
    for (int j = 0; j < k; j++) {
      b[j] = set(a[j], n);
      f[j] = set(f0[j], m);
    }
    
    for (int i = 0; i < n; i++) {
      delete [] f0[i];
      delete [] a[i];
    }
    delete [] f0;
    delete [] a;
  }
  MPI_Barrier(MPI_COMM_WORLD);
  MPI_Bcast(y0, n, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(y1, n, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(y2, n, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(y, n, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  
  if (rank != 0) {
    for (int i = rank * k; i < (rank + 1) * k; i++) {
      Vector temp_b = new double[n];
      Vector temp_f = new double[m];
      MPI_Recv(temp_b, n, MPI_DOUBLE, 0, i, MPI_COMM_WORLD, &status);
      b[i - rank * k] = set(temp_b, n);
      MPI_Recv(temp_f, m, MPI_DOUBLE, 0, i, MPI_COMM_WORLD, &status);
      f[i - rank * k] = set(temp_f, m);
      delete [] temp_b;
      delete [] temp_f;
    }
  }
  
  Vector v3 = new double[k];
  Vector v2 = new double[k];
  Vector v1 = new double[k];
  Vector v0 = new double[k];

  Vector yp = new double[k];
  Vector yc = new double[k];
  Vector vn = new double[k];
  Vector yn = new double[k];
  double norma;
  bool ft = true;
  
  Vector temp_yn = new double[k];
  MPI_Barrier(MPI_COMM_WORLD);
  
  if (rank == 0)
    start = MPI_Wtime();
  for (int point = 4; point < xk; point++) {
    if (ft) {
      v3 = v(b, y, f, x, k, n);
      v2 = v(b, y2, f, x - h, k, n);
      v1 = v(b, y1, f, x - 2 * h, k, n);
      v0 = v(b, y0, f, x - 3 * h, k, n);
      ft = false;
    }
    for (int i = 0; i < k; i++)
      yn[i] = y[rank * k + i];

    norma = 100.0 * eps;      
    yp = sum(yn, mul(sum(sub(mul(v3, 55.0, k), mul(v2, 59.0, k), k),
      sub(mul(v1, 37.0, k), mul(v0, 9.0, k), k), k), h / 24, k), k);
    
    x += h;
    
    while (norma > eps) {
      vn = v(b, yp, f, x, k, n);  
      yc = sum(yn, mul(sum(sum(mul(vn, 9.0, k), mul(v3, 19.0, k), k),
        sub(mul(v2, 5.0, k), v1, k), k), h / 24, k), k);
      norma = norm(sub(yc, yp, k), k);
      yp = set(yc, k);
    }
    
    yn = set(yc, k);
    v0 = set(v1, k);
    v1 = set(v2, k);
    v2 = set(v3, k);
    v3 = set(v(b, yn, f, x, k, n), k); 
    
    MPI_Barrier(MPI_COMM_WORLD);
    MPI_Allgather(yn, k, MPI_DOUBLE, y, k, MPI_DOUBLE, MPI_COMM_WORLD);
    printf("%d ended pt: %d\n", rank, point);
  }
  
  if (rank == 0) {
    finish = MPI_Wtime();
    double time = finish - start;
    
    printf("Elapsed time: %.3lf\n", time);  
  }
  
  MPI_Finalize();
  return 0;
}
