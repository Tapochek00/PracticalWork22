using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
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

        private void AddRecord_btn_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SubscriptionTable sub = new SubscriptionTable();

                // Проверка корректности ввода
                StringBuilder errors = new StringBuilder();
                if (comboPubl.Text.Length == 0)
                    errors.AppendLine("Выберите издание");
                if (comboOrg.Text.Length == 0)
                    errors.AppendLine("Выберите организацию");
                if (months.Text.Length == 0) errors.AppendLine("Введите количество месяцев");

                if (errors.Length > 0)
                {
                    MessageBox.Show(errors.ToString());
                    return;
                }

                // Поиск записей в связанных таблицах
                string[] findPubl = comboPubl.Text.Split(' ');
                string[] findOrg = comboOrg.Text.Split(' ');

                // Заполнение данных добавляемой записи
                sub.SubscriptionDate = DateTime.Now;
                sub.Months = int.Parse(months.Text);
                if (discount.Text.Length == 0) sub.Discount = 0;
                else sub.Discount = int.Parse(discount.Text);
                sub.Publication = int.Parse(findPubl[0]);
                sub.Organization = int.Parse(findOrg[0]);

                // Добавление записи и закрытие окна добавления
                db.SubscriptionTable.Add(sub);
                db.SaveChanges();
                Close();
            }
            catch { }
        }

        OrganizationsEntities db = OrganizationsEntities.GetContext();
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            ComboBoxItem comboItem;
            // Заполнение выпадающих списков данными из базы данных
            foreach (var i in db.Publications)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Id.ToString() + " " + i.Name;
                comboPubl.Items.Add(comboItem);
            }

            foreach (var i in db.Organizations)
            {
                comboItem = new ComboBoxItem();
                comboItem.Content = i.Id.ToString() + " " + i.Name;
                comboOrg.Items.Add(comboItem);
            }
        }

        // Ограничение ввода некорректных значений в поля ввода
        private void discount_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            Regex reg = new Regex(@"[^0-9.]+");
            e.Handled = reg.IsMatch(e.Text);
        }

        private void months_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            Regex reg = new Regex("[^0-9]+");
            e.Handled = reg.IsMatch(e.Text);
        }
    }
}
