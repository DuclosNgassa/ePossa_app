import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/pages/popup/change_name_popup.dart';
import 'package:epossa_app/pages/popup/change_password_popup.dart';
import 'package:epossa_app/pages/popup/change_phonenumber_popup.dart';
import 'package:epossa_app/pages/popup/finance_popup.dart';
import 'package:epossa_app/pages/popup/popup_helper.dart';
import 'package:epossa_app/util/size_config.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
//      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5, vertical:  SizeConfig.blockSizeVertical * 4),
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5,right: SizeConfig.blockSizeHorizontal * 5, top: SizeConfig.blockSizeVertical *5),
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
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('my_account'),
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 5,),
        Text(
          _getUser().name,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          _getUser().phone_number,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
              onTap: () => PopupHelper.showPopup(
                  context, FinancePopup(), AppLocalizations.of(context).translate('my_finance'),),
              leading: Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context).translate('my_finance'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          FadeAnimation(
            1.6,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context, ChangeNamePopup(), AppLocalizations.of(context).translate('change_name'),),
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_name'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          FadeAnimation(
            1.9,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context,
                  ChangePhonenumberPopup(),
                  AppLocalizations.of(context).translate('change_phonenumber'),),
              leading: Icon(
                Icons.phone_iphone,
                color: Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_phonenumber'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
          ),
          FadeAnimation(
            2.2,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context, ChangePasswordPopup(), AppLocalizations.of(context).translate('change_password'),),
              leading: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: Text(
                AppLocalizations.of(context).translate('change_password'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  User _getUser() {
    User user = new User();
    user.phone_number = "00237 67 45 34 98";
    user.name = "Max Mustermann";
    user.balance = 37250;

    return user;
  }
}
