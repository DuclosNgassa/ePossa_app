import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/pages/authentication/signin_page.dart';
import 'package:epossa_app/pages/navigation/navigation_page.dart';
import 'package:epossa_app/services/authentication_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  AuthenticationService _authenticationService = new AuthenticationService();
  UserService _userService = new UserService();

  FocusNode _phoneNumberFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: GlobalColor.colorWhite,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Center(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildBackground(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeVertical * 5),
                        child: Column(
                          children: <Widget>[
                            _buildLoginInput(),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            _buildLoginButton(),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            _buildSignInButton(),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            _buildPasswordForgottenButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      height: SizeConfig.screenHeight * 0.5,
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
          AppLocalizations.of(context).translate("login"),
          style: TextStyle(
              color: GlobalColor.colorWhite,
              fontSize: SizeConfig.blockSizeHorizontal * 9,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLoginInput() {
    return FadeAnimation(
      2.2,
      Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .3),
                blurRadius: 20.0,
                offset: Offset(0, 10),
              )
            ],
            color: GlobalColor.colorWhite),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]),),),
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
                textInputAction: TextInputAction.next,
                focusNode: _phoneNumberFocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_phoneNumberFocusNode, _passwordFocusNode);
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
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (term) {
                  //TODO doLogin()
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
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return FadeAnimation(
      2.5,
      GestureDetector(
        onTap: () => _login(),
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
              AppLocalizations.of(context).translate("login").toUpperCase(),
              style: TextStyle(
                  color: GlobalColor.colorWhite,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return FadeAnimation(
      2.8,
      GestureDetector(
        onTap: () => _signIn(),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: AppLocalizations.of(context).translate("no_account"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: AppLocalizations.of(context).translate("create_account"),
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

  Widget _buildPasswordForgottenButton() {
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

  _login() async {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('info'),
          AppLocalizations.of(context).translate('correct_form_errors'),
          Icon(
            Icons.error,
            size: 28,
            color: Colors.red.shade300,
          ),
          Colors.red.shade300,
          2);
    } else {
      bool login = await _authenticationService.login(
          _phoneNumberController.text, _passwordController.text);

      if (login) {
        UserDTO user =
            await _userService.readByPhoneNumber(_phoneNumberController.text);
        _navigateToStartPage();
      } else {
        //TODO implements count number of try and if > 3 block account for 30Min
        MyNotification.showInfoFlushbar(
            context,
            AppLocalizations.of(context).translate('error'),
            AppLocalizations.of(context).translate('error_login_data') +
                "\n" +
                AppLocalizations.of(context).translate('try_again'),
            Icon(
              Icons.error,
              size: 28,
              color: Colors.red.shade300,
            ),
            Colors.red.shade300,
            3);
      }
    }
  }

  _navigateToStartPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavigationPage()),
    );
  }

  _signIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
