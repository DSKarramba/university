#include <stdio.h>
#include <stdlib.h>
#include <math.h>

const double e   = 1.6E-19;
const double m_e = 9.1E-31;
const double k   = 1.38E-23;
const double h   = 6.63E-34;
const double h2  = h * h;
const double h3  = h * h * h;

const float  m_p = 0.56 * m_e;
const float  m_n = 1.08 * m_e;
const float  E_c = 4.02;
const float  E_g = 1.21;
const float  E_v = E_c + E_g;
const float  F   = E_c + E_g / 2.0;

char elem_name[] = "Si";
char def_file[] = "data.txt";

double n_x(float m_x, float T)
{
  return 2.0 * pow(2.0 * M_PI * m_x * k * T / h2, 1.5) * 1E-6; 
}

double fermi(double E, double T)
{
  return 1.0 / (1 + exp((E - F)*e / (k * T)));
}

double boltz(double E, double T)
{
  return exp(-(E - F)*e/(k * T));
}

double f(double m, double E)
{
  return 4.0 * M_PI * pow(m, 1.5) * sqrt(2.0 * (E - E_c)) / h3;
}

double n_e(float E)
{
  return 4.0 * M_PI * pow(m_n, 1.5) * sqrt(2.0 * (E - E_c*e) / h3);
}

int main(void)
{
  FILE *f, *p;
  const float T0 = 100.0f, T1 = 1000.0f, dt = 10.0f;
  float T, E;
  double N_c, N_v, n_i;

  f = fopen(def_file, "w");
  for (T = T0; T < T1; T += dt) {
    N_c = n_x(m_n, T);
    N_v = n_x(m_p, T);
    n_i = pow(N_c * N_v, 0.5f) * exp(-E_g * e / (2.0f * k * T));
    fprintf(f, "%.4E %.4E %.4E %.4E\n", 1000.0f / T, n_i, N_c, N_v);
  }
  fclose(f);

  p = popen("gnuplot -p", "w");
  fprintf(p, 
    "set terminal pdfcairo enhanced color font 'Ubuntu, 10' size 4.0in, 3.0in\n"
        "set border 3\n"
    "set grid\n"
    "set output 'n_i.pdf'\n"
    "set title '%s'\n"
    "set key outside right center spacing 1.3\n"
    "set logscale y\n"
    "set xtics 1.0\n"
    "set format x '%%.1f'\n"
    "set format y '10^{%%L}'\n"
    "set xlabel '1000/T, K^{-1}'\n"
    "set ylabel 'n, cm^{-3}'\n", elem_name);
  fprintf(p, "plot '%s' using 1:2 title ' n_i' with lines lc 1 lw 4 lt 1, "
           "'%s' using 1:3 title ' N_c' with lines lc 2 lw 4 lt 2, "
           "'%s' using 1:4 title ' N_v' with lines lc 3 lw 4 lt 5\n", 
       def_file, def_file, def_file);
  pclose(p);

  f = fopen(def_file, "w");
  for (E = E_c - E_g / 2.0; E <= E_v + E_g / 2.0f; E += 1E-3) {
    fprintf(f, "%.4E %.4E %.4E %.4E %.4E %.4E %.4E %.4E\n", 
         E*e, fermi(E, 0.001), 
         fermi(E, 1500), boltz(E, 1500));
  }
  fclose(f);

  p = popen("gnuplot -p", "w"); 
  fprintf(p,
    "set terminal pdfcairo enhanced color font 'Ubuntu, 10'\n"
        "set border 3\n"
    "set grid\n"
    "set output 'f.pdf'\n"
    "set title '%s'\n"
    "set xrange [0:1]\n"
    "set xtics 0.1\n"
    "set format y '%%.1t×10^{%%T}'\n"
    "set key outside right center spacing 1.3\n"
    "set xlabel 'f'\n"
    "set ylabel 'E, J'\n", elem_name 
  );
  fprintf(p, "plot '%s' using 2:1 title 'Fermi, T = 0 K' with lines lc 1 lw 4 lt 1, "
        "'%s' using 3:1 title 'Fermi, T = 1500 K' with lines lc 2 lw 4 lt 1, "
        "'%s' using 4:1 title 'Boltzmann, T = 1500 K' with lines lc 3 lw 4 lt 1\n",
       def_file, def_file, def_file);

  pclose(p);

  f = fopen(def_file, "w");
  for (E = 0.0f; E < 1.0f; E += 1E-3) {
    fprintf(f, "%.4E %.4E\n", E, n_e(E));
  }
  fclose(f);

  p = popen("gnuplot -p", "w"); 
  fprintf(p, 
    "set terminal pdfcairo enhanced color font 'Ubuntu, 10'\n"
        "set border 3\n"
    "set grid\n"
    "set output 'N_E.pdf'\n"
    "set title '%s'\n"
    "set format x '%%.1t×10^{%%T}'\n"
    "set format y '%%.2f'\n"
    "set xrange [0:*]\n"
    "set xlabel 'N(E)'\n"
    "set ylabel 'E, J'\n", elem_name
  );
  fprintf(p, "plot '%s' using 2:1 notitle with lines lc 1 lw 4 lt 1\n", def_file);
  pclose(p);
  return EXIT_SUCCESS;
}
