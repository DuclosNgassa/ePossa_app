import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/custom_widget/custom_button.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/authentication/login_page.dart';
import 'package:epossa_app/pages/popup/change_name_popup.dart';
import 'package:epossa_app/pages/popup/change_password_popup.dart';
import 'package:epossa_app/pages/popup/change_phonenumber_popup.dart';
import 'package:epossa_app/pages/popup/controller/popup_content.dart';
import 'package:epossa_app/pages/popup/controller/popup_layout.dart';
import 'package:epossa_app/pages/popup/finance_popup.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userName = "";
  String phone = "";

  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5,
            top: SizeConfig.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1.3,
              _buildHeader(),
            ),
            FadeAnimation(
              1.3,
              SizedBox(
                height: SizeConfig.blockSizeVertical * 5,
              ),
            ),
            _buildListConfig(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                AppLocalizations.of(context).translate('my_account_header'),
                style: GlobalStyling.styleOpacityWhite,
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 2,
            ),
            CustomButton(
              fillColor: GlobalColor.colorRed,
              icon: FontAwesomeIcons.powerOff,
              splashColor: GlobalColor.colorWhite,
              iconColor: GlobalColor.colorWhite,
              text: AppLocalizations.of(context).translate('logout'),
              textStyle: TextStyle(
                  color: GlobalColor.colorWhite, fontSize: SizeConfig.buttonFontSize),
              onPressed: () => _logOut(),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 5,
        ),
        Text(
          userName,
          style: TextStyle(
              color: GlobalColor.colorWhite, fontSize: SizeConfig.safeBlockHorizontal * 8, fontWeight: FontWeight.bold),
        ),
        Text(
          phone,
          style: TextStyle(
              color: GlobalColor.colorWhite, fontSize: SizeConfig.safeBlockHorizontal * 8, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildListConfig() {
    return Container(
      height: SizeConfig.screenHeight * 0.5,
      child: ListView(
        children: <Widget>[
          FadeAnimation(
            1.6,
            ListTile(
              onTap: () => _showPopup(
                FinancePopup(),
                AppLocalizations.of(context).translate('my_finance'),
              ),
              leading: Icon(
                Icons.attach_money,
                color: GlobalColor.colorWhite,
              ),
              title: Text(AppLocalizations.of(context).translate('my_finance'),
                  style: GlobalStyling.styleNormalWhite),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            1.6,
            ListTile(
              onTap: () => _showPopup(
                ChangeNamePopup(),
                AppLocalizations.of(context).translate('change_name'),
              ),
              leading: Icon(
                Icons.person,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_name'),
                style: GlobalStyling.styleNormalWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            1.9,
            ListTile(
              onTap: () => _showPopup(
                ChangePhonenumberPopup(),
                AppLocalizations.of(context).translate('change_phonenumber'),
              ),
              leading: Icon(
                Icons.phone_iphone,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_phonenumber'),
                style: GlobalStyling.styleNormalWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            2.2,
            ListTile(
              onTap: () => _showPopup(
                ChangePasswordPopup(),
                AppLocalizations.of(context).translate('change_password'),
              ),
              leading: Icon(
                Icons.lock,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_password'),
                style: GlobalStyling.styleNormalWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showPopup(Widget widget, String title, {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: SizeConfig.blockSizeVertical * 4,
        left: SizeConfig.blockSizeHorizontal * 6,
        right: SizeConfig.blockSizeHorizontal * 6,
        bottom: SizeConfig.blockSizeVertical * 6,
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
    ).then((_) async {
      _getUser();
    });
  }

  void _getUser() async {
    userName = await _sharedPreferenceService.read(USER_NAME);
    phone = await _sharedPreferenceService.read(USER_PHONE);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
