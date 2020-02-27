import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/login_page.dart';
import 'package:epossa_app/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'navigation_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _password1Controller = new TextEditingController();
  TextEditingController _password2Controller = new TextEditingController();

  FocusNode _nameFocusNode;
  FocusNode _phoneNumberFocusNode;
  FocusNode _password1FocusNode;
  FocusNode _password2FocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = new FocusNode();
    _phoneNumberFocusNode = new FocusNode();
    _password1FocusNode = new FocusNode();
    _password2FocusNode = new FocusNode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _nameController.dispose();
    _phoneNumberController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildBackground(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeVertical * 5),
                    child: Column(
                      children: <Widget>[
                        _buildSigninInput(context),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        _buildSigninButton(context),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        _buildLoginButton(context),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        _buildPasswordForgottenButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildBackground(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 6,
            width: SizeConfig.blockSizeHorizontal * 20,
            height: SizeConfig.blockSizeVertical * 35,
            child: FadeAnimation(
              1,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 35,
            width: SizeConfig.blockSizeHorizontal * 25,
            height: SizeConfig.blockSizeVertical * 22,
            child: FadeAnimation(
              1.3,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-2.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: SizeConfig.blockSizeHorizontal * 10,
            top: SizeConfig.blockSizeVertical * 5,
            width: SizeConfig.blockSizeHorizontal * 25,
            height: SizeConfig.blockSizeVertical * 22,
            child: FadeAnimation(
              1.6,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
              child: _buildFormTitle(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTitle(BuildContext context) {
    return FadeAnimation(
      1.9,
      Center(
        child: Text(
          AppLocalizations.of(context).translate("signin"),
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSigninInput(BuildContext context) {
    return FadeAnimation(
      2.2,
      Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .3),
                blurRadius: 20.0,
                offset: Offset(0, 10),
              )
            ],
            color: Colors.white),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _nameController,
                textInputAction: TextInputAction.next,
                focusNode: _nameFocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_nameFocusNode, _phoneNumberFocusNode);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(.8),
                  ),
                  hintText: AppLocalizations.of(context).translate("name"),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('name_please');
                  }
                  return null;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                focusNode: _phoneNumberFocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_phoneNumberFocusNode, _password1FocusNode);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.phone_iphone),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(.8),
                  ),
                  hintText:
                      AppLocalizations.of(context).translate("phonenumber"),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('phonenumber_please');
                  }
                  return null;
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: _password1Controller,
                textInputAction: TextInputAction.next,
                focusNode: _password1FocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_password1FocusNode, _password2FocusNode);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                  hintText: AppLocalizations.of(context).translate("password"),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('password_please');
                  }
                  return null;
                },
              ),
            ),
            Container(
              child: TextFormField(
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: _password2Controller,
                focusNode: _password2FocusNode,
                onFieldSubmitted: (term) {
                  //TODO doSignIn()
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                  hintText:
                      AppLocalizations.of(context).translate("password_repeat"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSigninButton(BuildContext context) {
    return FadeAnimation(
      2.5,
      GestureDetector(
        onTap: () => _signIn(context),
        child: Container(
          //width: 120,
          height: SizeConfig.blockSizeVertical * 8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, 6),
              ])),
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate("signin").toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return FadeAnimation(
      2.8,
      GestureDetector(
        onTap: () => _login(context),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text:
                  AppLocalizations.of(context).translate("already_registered"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: AppLocalizations.of(context).translate("to_login"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  _signIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationPage()),
    );
  }

  _login(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildPasswordForgottenButton(BuildContext context) {
    return FadeAnimation(
      3.1,
      GestureDetector(
        onTap: () => print("Password forgotten..."),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: AppLocalizations.of(context).translate("forgot_password"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            )
          ]),
        ),
      ),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

}
