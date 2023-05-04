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
    /// Логика взаимодействия для SearchWin.xaml
    /// </summary>
    public partial class SearchWin : Window
    {
        public SearchWin()
        {
            InitializeComponent();
        }

        private void Search_btn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                Data.Date = (DateTime)Date.SelectedDate;
                Data.PublName = Publication.Text;
                Data.OrgName = Organization.Text;
                Close();
            }
            catch (System.InvalidOperationException)
            {
                MessageBox.Show("Введите запрос");
            }
        }
    }
}
