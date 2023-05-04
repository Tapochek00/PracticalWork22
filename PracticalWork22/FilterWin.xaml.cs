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
            // Передача данных в класс Data и закрытие окна
            Data.FiltParam = combo.Text;
            Data.Filter = filt.Text;
            Close();
        }

        OrganizationsEntities db = OrganizationsEntities.GetContext();
        private void combo_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // Заполнение выпадающих списков данными из базы данных
            filt.Items.Clear();
            if (combo.Text == "Издание")
            {
                foreach(var publ in db.Organizations)
                {
                    ComboBoxItem comboItem = new ComboBoxItem();
                    comboItem.Content = publ.Name;
                    filt.Items.Add(comboItem);
                }
            }
            else
            {
                foreach(var org in db.Publications)
                {
                    ComboBoxItem comboItem = new ComboBoxItem();
                    comboItem.Content = org.Name;
                    filt.Items.Add(comboItem);
                }
            }
            filt.IsEnabled = true;
        }

        private void filt_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Search_btn.IsEnabled = true;
        }
    }
}
