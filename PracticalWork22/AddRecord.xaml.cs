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
    /// Логика взаимодействия для AddRecord.xaml
    /// </summary>
    public partial class AddRecord : Window
    {
        public AddRecord()
        {
            InitializeComponent();
        }

        Publications publ = new Publications();
        Organizations org
        private void AddRecord_btn_Click(object sender, RoutedEventArgs e)
        {
            publ = db.Orders.Find(Data.recordId);
            orderList = db.OrderList.Find(Data.recordId);
        }

        private void AddPhoto_Click(object sender, RoutedEventArgs e)
        {

        }

        OrganizationsEntities db = OrganizationsEntities.GetContext();
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ComboBoxItem comboItem;
            foreach (var i in db.Publications)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Name;
                comboPubl.Items.Add(comboItem);
            }

            foreach (var i in db.Organizations)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Name;
                comboPubl.Items.Add(comboItem);
            }
        }
    }
}
