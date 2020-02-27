import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/account/account_page.dart';
import 'package:epossa_app/pages/history/history_page.dart';
import 'package:epossa_app/pages/home/home_page.dart';
import 'package:epossa_app/pages/popup/payment_popup.dart';
import 'package:epossa_app/pages/popup/popup_helper.dart';
import 'package:epossa_app/pages/popup/receive_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(112, 139, 245, 1),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              AppLocalizations.of(context).translate('home'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
            ),
            title: Text(
              AppLocalizations.of(context).translate('history'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            title: Text(
              AppLocalizations.of(context).translate('my_account'),
            ),
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(51, 51, 153, 1),
        unselectedItemColor: Color.fromRGBO(112, 139, 245, 1),
        onTap: _onItemTapped,
      ),
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        backgroundColor: Color.fromRGBO(51, 51, 153, 1),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.account_balance_wallet, color: Colors.white),
            title: AppLocalizations.of(context).translate('pay'),
            titleColor: Colors.white,
            subtitle: AppLocalizations.of(context).translate('pay_service'),
            subTitleColor: Colors.white,
            backgroundColor: Colors.purple,
            onTap: () => PopupHelper.showPopup(
              context,
              PaymentPopup(),
              AppLocalizations.of(context).translate('pay_service'),
            ),
          ),
          MenuItem(
            child: Icon(Icons.exit_to_app, color: Colors.white),
            title: AppLocalizations.of(context).translate('receive_money'),
            titleColor: Colors.white,
            subtitle: AppLocalizations.of(context)
                .translate('monetize_your_services'),
            subTitleColor: Colors.white,
            backgroundColor: Colors.cyan,
            onTap: () => PopupHelper.showPopup(context, ReceivePopup(),
                AppLocalizations.of(context).translate('receive_money')),
          ),
        ],
      ),
    );
  }
}
