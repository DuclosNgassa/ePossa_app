import 'package:epossa_app/pages/account_page.dart';
import 'package:epossa_app/pages/history_page.dart';
import 'package:epossa_app/pages/home_page.dart';
import 'package:epossa_app/pages/popup.dart';
import 'package:epossa_app/pages/popup/payment_popup.dart';
import 'package:epossa_app/pages/popup/receive_popup.dart';
import 'package:epossa_app/pages/popup_content.dart';
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
      backgroundColor: Color.fromRGBO(102, 0, 204, 50),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
            ),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            title: Text('My Account'),
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(3, 9, 23, 1),
        unselectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),

      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        scrollVisible: true,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.account_balance_wallet, color: Colors.white),
            title: 'Payer',
            titleColor: Colors.white,
            subtitle: "Achetez un service",
            subTitleColor: Colors.white,
            backgroundColor: Colors.cyan,
            onTap: () =>
                showPopup(context, PaymentPopup(), 'Payement de services'),
          ),
          MenuItem(
            child: Icon(Icons.exit_to_app, color: Colors.white),
            title: 'Vendre',
            titleColor: Colors.white,
            subtitle: "Monetisez vos services",
            subTitleColor: Colors.white,
            backgroundColor: Colors.purple,
            onTap: () =>
                showPopup(context, ReceivePopup(), 'Reception de fonds'),
          ),
        ],
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 30,
        left: 30,
        right: 30,
        bottom: 50,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue[800],
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }
}
