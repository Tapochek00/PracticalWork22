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
            Login login = new Login();
            login.ShowDialog();

            if (Data.Login == false) Close();
            if (Data.Right != "Администратор")
            {
                Add.IsEnabled = false;
                Edit.IsEnabled = false;
            }

            mainWin.Title = Data.FullName + " - " + Data.Right;
        }

        private void Search_btn_Click(object sender, RoutedEventArgs e)
        {
            SearchWin win = new SearchWin();
            win.Owner = this;
            win.ShowDialog();

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

            try
            {
                var table = db.View_1.ToList();
                IEnumerable<View_1> filtered;

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
            }
        }

        private void Exit_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }
    }
}
