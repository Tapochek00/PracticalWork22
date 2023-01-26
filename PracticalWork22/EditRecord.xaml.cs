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
    /// Логика взаимодействия для EditRecord.xaml
    /// </summary>
    public partial class EditRecord : Window
    {
        public EditRecord()
        {
            InitializeComponent();
        }

        private void AddRecord_btn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                int mon = int.Parse(months.Text);

                StringBuilder errors = new StringBuilder();
                if (comboPubl.Text.Length == 0)
                    errors.AppendLine("Выберите издание");
                if (comboOrg.Text.Length == 0)
                    errors.AppendLine("Выберите организацию");
                if (months.Text.Length == 0) errors.AppendLine("Введите количество месяцев");
                if (mon > 12 || mon <= 0) errors.AppendLine("Введите правильное количество месяцев");

                if (errors.Length > 0)
                {
                    MessageBox.Show(errors.ToString());
                    return;
                }

                string[] find = comboPubl.Text.Split(' ');
                Publications publ = db.Publications.Find(int.Parse(find[0]));

                find = comboOrg.Text.Split(' ');
                Organizations org = db.Organizations.Find(int.Parse(find[0]));

                sub.SubscriptionDate = DateTime.Now;
                sub.Months = int.Parse(months.Text);
                if (discount.Text.Length == 0) sub.Discount = 0;
                else sub.Discount = int.Parse(discount.Text);
                sub.Publication = publ.Id;
                sub.Organization = org.Id;

                db.SaveChanges();
                Close();
            }
            catch { }
        }

        OrganizationsEntities db = OrganizationsEntities.GetContext();
        SubscriptionTable sub;
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ComboBoxItem comboItem;
            sub = db.SubscriptionTable.Find(Data.Id);

            foreach (var i in db.Publications)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Id.ToString() + " " + i.Name;
                if (i.Id == sub.Publication) comboItem.IsSelected = true;
                comboPubl.Items.Add(comboItem);
            }

            foreach (var i in db.Organizations)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Id.ToString() + " " + i.Name;
                if (i.Id == sub.Organization) comboItem.IsSelected = true;
                comboOrg.Items.Add(comboItem);
            }

            months.Text = sub.Months.ToString();
            discount.Text = sub.Discount.ToString();
        }
    }
}
