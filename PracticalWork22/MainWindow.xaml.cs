using System;
using System.Collections.Generic;
using System.Data.Entity;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace PracticalWork22
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        OrganizationsEntities db = OrganizationsEntities.GetContext();
        private void mainWin_Loaded(object sender, RoutedEventArgs e)
        {
            db.View_1.Load();
            listview.ItemsSource = db.View_1.Local.ToBindingList();
        }

        private void mainWin_Initialized(object sender, EventArgs e)
        {
            // Вход и определение прав пользователя
            Login login = new Login();
            login.ShowDialog();

            if (Data.Login == false) Close();
            if (Data.Right != "Администратор")
            {
                Add.IsEnabled = false;
                Edit.IsEnabled = false;
                Delete.IsEnabled = false;
                AddMenu.IsEnabled = false;
                EditMenu.IsEnabled = false;
                DeleteMenu.IsEnabled = false;
            }

            mainWin.Title = Data.FullName + " - " + Data.Right;
        }

        private void Search_btn_Click(object sender, RoutedEventArgs e)
        {
            SearchWin win = new SearchWin();
            win.Owner = this;
            win.ShowDialog();

            // Проверка каждой записи в listview до нахождения соответствия
            foreach (var item in listview.Items)
            {
                var row = (View_1)item;
                string date = row.SubscriptionDate.ToString();
                string publ = row.PublName;
                string org = row.OrgName;
                string selectedDate = Data.Date.ToString();

                if (date.Contains(selectedDate) &&
                    publ.Contains(Data.PublName) &&
                    org.Contains(Data.OrgName))
                {
                    listview.SelectedItem = item;
                    listview.ScrollIntoView(item);
                    break;
                }
            }
        }

        private void Filter_btn_Click(object sender, RoutedEventArgs e)
        {
            FilterWin win = new FilterWin();
            win.Owner = this;
            win.ShowDialog();

            db.View_1.Load();
            listview.ItemsSource = db.View_1.Local.ToBindingList();

            try
            {
                var table = db.View_1.ToList();
                IEnumerable<View_1> filtered;

                // Добавление совпадений в коллекцию filtered и отображение её в listview
                if (Data.FiltParam == "Издание") filtered = table.Where(p => p.PublName.Contains(Data.Filter));
                else filtered = table.Where(p => p.OrgName.Contains(Data.Filter));
                listview.ItemsSource = filtered;
            }
            catch { }
        }

        private void Reset_btn_Click(object sender, RoutedEventArgs e)
        {
            db.View_1.Load();
            listview.ItemsSource = db.View_1.Local.ToBindingList();
        }

        private void Add_Click(object sender, RoutedEventArgs e)
        {
            AddRecord add = new AddRecord();
            add.Owner = this;
            add.ShowDialog();

            db.View_1.Load();
            listview.ItemsSource = db.View_1.Local.ToBindingList();
        }

        private void Edit_Click(object sender, RoutedEventArgs e)
        {
            int indexRow = listview.SelectedIndex;
            if (indexRow != -1)
            {
                View_1 row = (View_1)listview.Items[indexRow];
                Data.Id = row.Id;
                EditRecord edit = new EditRecord();
                edit.Owner = this;
                edit.ShowDialog();
                db.View_1.Load();
                listview.ItemsSource = db.View_1.Local.ToBindingList();
                db.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
            }
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        // Удаление выбранной записи
        private void Delete_Click(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result;
            result = MessageBox.Show("Удалить запись?", "Удаление записи",
                MessageBoxButton.YesNo, MessageBoxImage.Warning);

            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    View_1 viewRow = (View_1)listview.SelectedValue;
                    SubscriptionTable row = db.SubscriptionTable.Find(viewRow.Id);
                    db.SubscriptionTable.Remove(row);
                    db.SaveChanges();
                    listview.Items.Refresh();
                    db.ChangeTracker.Entries().ToList().ForEach(p => p.Reload());
                }
                catch (ArgumentOutOfRangeException)
                {
                    MessageBox.Show("Выберите запись");
                }
            }
        }

        private void OrganizationsMenuBtn_Click(object sender, RoutedEventArgs e)
        {

        }

        private void PublicationsMenuBtn_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
