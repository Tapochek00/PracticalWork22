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
            if (Data.Right == "Клиент") ;
            else;

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

                if (date.Contains(Data.Date) &&
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

            var table = db.View_1.ToList();

            if (Data.FiltParam == "Дата подписки") ;

                var filtered = table.Where(p => p.SubscriptionDate);
        }
    }
}
