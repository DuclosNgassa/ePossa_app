import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/pages/popup/change_name_popup.dart';
import 'package:epossa_app/pages/popup/change_password_popup.dart';
import 'package:epossa_app/pages/popup/change_phonenumber_popup.dart';
import 'package:epossa_app/pages/popup/finance_popup.dart';
import 'package:epossa_app/pages/popup/popup_helper.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
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
              height: 50.0,
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
              "Account",
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 50,),
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
      height: 300,
      child: ListView(
        children: <Widget>[
          FadeAnimation(
            1.6,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context, FinancePopup(), 'Mes finances'),
              leading: Icon(
                Icons.attach_money,
                color: Colors.white,
              ),
              title: Text(
                "Mes finances",
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
            height: 10,
          ),
          FadeAnimation(
            1.6,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context, ChangeNamePopup(), 'Changement de nom'),
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Change Name",
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
            height: 10,
          ),
          FadeAnimation(
            1.9,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context,
                  ChangePhonenumberPopup(),
                  'Changement de numéro de téléphone'),
              leading: Icon(
                Icons.phone_iphone,
                color: Colors.white,
              ),
              title: Text(
                "Change Phonenumber",
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
            height: 10,
          ),
          FadeAnimation(
            2.2,
            ListTile(
              onTap: () => PopupHelper.showPopup(
                  context, ChangePasswordPopup(), 'Changement de mot de passe'),
              leading: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              title: Text(
                "Change Password",
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
