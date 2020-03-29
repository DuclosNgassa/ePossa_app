import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/account/account_page.dart';
import 'package:epossa_app/pages/help/info_page.dart';
import 'package:epossa_app/pages/history/history_page.dart';
import 'package:epossa_app/pages/home/home_page.dart';
import 'package:epossa_app/pages/popup/controller/popup_content.dart';
import 'package:epossa_app/pages/popup/controller/popup_layout.dart';
import 'package:epossa_app/pages/popup/payment_popup.dart';
import 'package:epossa_app/pages/popup/receive_popup.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: GlobalColor.colorWhite);

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
    AccountPage(),
    InfoPage(),
  ];

  static List<Color> _colorOptions = <Color>[
    GlobalColor.colorPrimary,
    GlobalColor.colorPrimary,
    GlobalColor.colorPrimary,
    GlobalColor.colorPrimary,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: _colorOptions.elementAt(_selectedIndex),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text(
              AppLocalizations.of(context).translate('infos'),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalColor.colorButtonPrimary,
        unselectedItemColor: GlobalColor.colorPrimary,
        onTap: _onItemTapped,
      ),
      floatingActionButton: buildBoomMenu(),
    );
  }

  buildBoomMenu() {
    return BoomMenu(
/*
      marginRight:
          (SizeConfig.screenWidth / 2) - SizeConfig.blockSizeHorizontal * 7,
*/
      //marginBottom: - SizeConfig.blockSizeHorizontal * 3,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme:
          IconThemeData(size: SizeConfig.blockSizeHorizontal * 8),
      backgroundColor: GlobalColor.colorButtonPrimary,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      scrollVisible: true,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
          child: Icon(Icons.account_balance_wallet, color: GlobalColor.colorWhite),
          title: AppLocalizations.of(context).translate('pay'),
          titleColor: GlobalColor.colorWhite,
          subtitle: AppLocalizations.of(context).translate('pay_service'),
          subTitleColor: GlobalColor.colorWhite,
          backgroundColor: Colors.purple,
          onTap: () => showPopup(
            context,
            PaymentPopup(),
            AppLocalizations.of(context).translate('pay_service'),
          ),
        ),
        MenuItem(
          child: Icon(Icons.exit_to_app, color: GlobalColor.colorWhite),
          title: AppLocalizations.of(context).translate('receive_money'),
          titleColor: GlobalColor.colorWhite,
          subtitle:
              AppLocalizations.of(context).translate('monetize_your_services'),
          subTitleColor: GlobalColor.colorWhite,
          backgroundColor: Colors.cyan,
          onTap: () => showPopup(context, ReceivePopup(),
              AppLocalizations.of(context).translate('receive_money')),
        ),
      ],
    );
  }

  void showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: SizeConfig.blockSizeVertical * 4,
        left: SizeConfig.blockSizeHorizontal * 6,
        right: SizeConfig.blockSizeHorizontal * 6,
        bottom: SizeConfig.blockSizeVertical * 6,
        standardsize:true,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              backgroundColor: GlobalColor.colorPrimary,
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {
                      print(e.toString());
                    }
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
    ).then((_) {
      setState(() {});
    });
  }
}
