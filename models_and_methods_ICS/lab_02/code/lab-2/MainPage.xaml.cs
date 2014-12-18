using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;

namespace lab_2
{
    public partial class MainPage : PhoneApplicationPage
    {
        double memory = 0;
        double first = 0;
        bool error = false;
        bool dot_set = false;
        bool but_click = false;
        int last_operation;
        enum ops {eq, plus, minus, div, mul};

        public MainPage()
        {
            InitializeComponent();
        }

        private void Calc(int op)
        {
            if (tbf.Text == "")
            {
                if (op != (int)ops.eq)
                {
                    first = Convert.ToDouble(tbin.Text);
                    tbf.Text = first.ToString();
                    last_operation = op;
                    dot_set = false;
                    switch (last_operation)
                    {
                        case (int)ops.plus:
                            {
                                tbf.Text += " +";
                                break;
                            }
                        case (int)ops.minus:
                            {
                                tbf.Text += " -";
                                break;
                            }
                        case (int)ops.div:
                            {
                                tbf.Text += " /";
                                break;
                            }
                        case (int)ops.mul:
                            {
                                tbf.Text += " *";
                                break;
                            }
                    }
                }
            }
            else
            {
                double second = Convert.ToDouble(tbin.Text);
                double temp = first;
                dot_set = false;
                error = false;
                switch (last_operation)
                {
                    case (int)ops.plus:
                        {
                            temp = first + second;
                            break;
                        }
                    case (int)ops.minus:
                        {
                            temp = first - second;
                            break;
                        }
                    case (int)ops.div:
                        {
                            if (second != 0)
                                temp = first / second;
                            else
                            {
                                tbin.Text = "ERROR";
                                error = true;
                            }
                            break;
                        }
                    case (int)ops.mul:
                        {
                            temp = first * second;
                            break;
                        }
                }
                if (!error)
                {
                    tbin.Text = "0";
                    tbf.Text = temp.ToString();
                    first = temp;
                    switch (op)
                    {
                        case (int)ops.plus:
                            {
                                tbf.Text += " +";
                                break;
                            }
                        case (int)ops.minus:
                            {
                                tbf.Text += " -";
                                break;
                            }
                        case (int)ops.div:
                            {
                                tbf.Text += " /";
                                break;
                            }
                        case (int)ops.mul:
                            {
                                tbf.Text += " *";
                                break;
                            }
                        case (int)ops.eq:
                            {
                                tbf.Text = "";
                                tbin.Text = first.ToString();
                                break;
                            }
                    }
                    last_operation = op;
                }
            }
            but_click = false;
        }

        private void bn_Click(object sender, RoutedEventArgs e)
        {
            Button _button = (Button)sender;
            int num = Convert.ToInt32(_button.Tag.ToString());
            if (!error)
            {
                if (tbin.Text == "0" || !but_click)
                    tbin.Text = num.ToString();
                else
                    tbin.Text += num.ToString();
                but_click = true;
            }
        }

        private void bd_Click(object sender, RoutedEventArgs e)
        {
            if (!error && !dot_set)
            {
                if (!but_click)
                    tbin.Text = "0";
                tbin.Text += ",";
                dot_set = true;
                but_click = true;
            }
        }

        private void bc_Click(object sender, RoutedEventArgs e)
        {
            tbin.Text = "0";
            tbf.Text = "";
            first = 0;
            last_operation = 0;
            error = false;
            dot_set = false;
            bp.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bm.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bdiv.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bmul.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
        }

        private void bce_Click(object sender, RoutedEventArgs e)
        {
            tbin.Text = "0";
            error = false;
            dot_set = false;
        }

        private void bb_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
            {
                if (tbin.Text.Length > 1)
                    tbin.Text = tbin.Text.Substring(0, tbin.Text.Length - 1);
                else
                    tbin.Text = "0";
                if (!tbin.Text.Contains(','))
                    dot_set = false;
            }
        }

        private void bms_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
                memory = Convert.ToDouble(tbin.Text);
            tbm.Text = String.Format("memory: {0}", memory);
        }

        private void bmr_Click(object sender, RoutedEventArgs e)
        {
            tbin.Text = memory.ToString();
            error = false;
            if (tbin.Text.Contains(','))
                dot_set = true;
        }

        private void bmp_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
                memory += Convert.ToDouble(tbin.Text);
            tbm.Text = String.Format("memory: {0}", memory);
        }

        private void bmm_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
                memory -= Convert.ToDouble(tbin.Text);
            tbm.Text = String.Format("memory: {0}", memory);
        }

        private void bmc_Click(object sender, RoutedEventArgs e)
        {
            memory = 0;
            tbm.Text = "";
        }

        private void bsqrt_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
            {
                double temp = Convert.ToDouble(tbin.Text);
                if (temp >= 0)
                    tbin.Text = Math.Sqrt(temp).ToString();
                else
                {
                    tbin.Text = "ERROR";
                    error = true;
                }
            }
        }

        private void bx_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
            {
                double temp = Convert.ToDouble(tbin.Text);
                if (temp != 0)
                    tbin.Text = (1 / temp).ToString();
                else
                {
                    tbin.Text = "ERROR";
                    error = true;
                }
            }
        }

        private void bper_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
            {
                double temp = Convert.ToDouble(tbin.Text);
                temp *= first / 100;
                tbin.Text = temp.ToString();
            }
        }

        private void bpm_Click(object sender, RoutedEventArgs e)
        {
            if (!error)
                tbin.Text = (-Convert.ToDouble(tbin.Text)).ToString();
        }

        private void bcom_Click(object sender, RoutedEventArgs e)
        {
            Button _button = (Button)sender;
            if (!error)
            {
                int op = Convert.ToInt32(_button.Tag.ToString());
                Calc(op);
                light(sender);
            }
        }

        private void light(object sender)
        {
            bp.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bm.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bmul.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            bdiv.Background = new SolidColorBrush(Color.FromArgb(0x00, 0, 0, 0));
            Button _button = (Button)sender;
            if (_button != beq)
                _button.Background = new SolidColorBrush(Color.FromArgb(0xff, 0x2e, 0x2e, 0x2e));
        }

    }
}