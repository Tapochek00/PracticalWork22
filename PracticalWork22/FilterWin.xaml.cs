using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace PracticalWork22
{
    /// <summary>
    /// Логика взаимодействия для FilterWin.xaml
    /// </summary>
    public partial class FilterWin : Window
    {
        public FilterWin()
        {
            InitializeComponent();
        }

        private void Search_btn_Click(object sender, RoutedEventArgs e)
        {
            Data.FiltParam = combo.Text;
            DatePicker date;
            TextBox tb;

            if (combo.Text == "Дата подписки")
            {
                date = new DatePicker { HorizontalAlignment = HorizontalAlignment.Center, Width = 100 };
                grid.Children.Add(date);
                Data.Filter = date.SelectedDate.ToString();
            }
            else
            {
                tb = new TextBox { HorizontalAlignment = HorizontalAlignment.Center, Width = 100 };
                grid.Children.Add(tb);
                Data.Filter = tb.Text;
            }

            Close();
        }
    }
}
