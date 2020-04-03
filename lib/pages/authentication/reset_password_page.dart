import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/reset_password.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/pages/authentication/one_time_password_page.dart';
import 'package:epossa_app/pages/authentication/signin_page.dart';
import 'package:epossa_app/services/authentication_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final int minvalue = 100000;
  final int maxvalue = 999999;

  AuthenticationService _authenticationService = new AuthenticationService();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser firebaseUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  FlutterOtp _flutterOtp = new FlutterOtp();

  Country _countryChoosed;
  String _phoneNumber;

  FocusNode _phoneNumberFocusNode;
  FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode = new FocusNode();
    _emailFocusNode = new FocusNode();

    _countryChoosed = CountryPickerUtils.getCountryByIsoCode('CM');
    _phoneNumber = "";
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);
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
      height: SizeConfig.screenHeight,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical * 35,
            child: FadeAnimation(
              1.3,
              Container(
                height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
          Positioned(
            left: SizeConfig.blockSizeHorizontal * 6,
            width: SizeConfig.blockSizeHorizontal * 20,
            height: SizeConfig.blockSizeVertical * 20,
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
            height: SizeConfig.blockSizeVertical * 15,
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
            height: SizeConfig.blockSizeVertical * 10,
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
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeVertical * 5),
                child: Column(
                  children: <Widget>[
                    _buildFormTitle(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 8,
                    ),
                    _buildPasswordResetInput(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    _buildPasswordResetButton(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    _buildLoginButton(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    _buildSignInButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFormTitle() {
    return FadeAnimation(
      1.9,
      Center(
        child: Text(
          AppLocalizations.of(context).translate("forgotten_password"),
          style: GlobalStyling.styleHeaderWhite,
        ),
      ),
    );
  }

  Widget _buildPasswordResetInput() {
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
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 4,
                ),
                child: _buildCountryPickerDropdown(),
              ),
            ),
            Container(
              child: TextFormField(
                onTap: () => onGoogleSignIn(),
                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _emailController,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (term) {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.email),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(.8),
                  ),
                  hintText: AppLocalizations.of(context).translate("email"),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)
                        .translate('email_please');
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

  Widget _buildCountryPickerDropdown(
      {bool filtered = true,
      bool sortedByIsoCode = true,
      bool hasPriorityList = false}) {
    return Row(
      children: <Widget>[
        CountryPickerDropdown(
          initialValue: 'CM',
          itemBuilder: _buildDropdownItem,
          itemFilter: filtered ? (c) => ['CM', 'DE'].contains(c.isoCode) : null,
          priorityList: hasPriorityList
              ? [
                  CountryPickerUtils.getCountryByIsoCode('CM'),
                  CountryPickerUtils.getCountryByIsoCode('DE'),
                ]
              : null,
          sortComparator: sortedByIsoCode
              ? (Country a, Country b) => a.isoCode.compareTo(b.isoCode)
              : null,
          onValuePicked: (Country country) {
            _countryChoosed = country;
            print("${_countryChoosed.iso3Code + " " + _countryChoosed.name}");
          },
        ),
        SizedBox(
          width: SizeConfig.blockSizeHorizontal,
        ),
        Expanded(
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            textInputAction: TextInputAction.next,
            focusNode: _phoneNumberFocusNode,
            onFieldSubmitted: (term) {
              _fieldFocusChange(_phoneNumberFocusNode, _emailFocusNode);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(.8),
              ),
              hintText: AppLocalizations.of(context).translate("phonenumber"),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context)
                    .translate('phonenumber_please');
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget _buildDropdownItem(Country country) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 6,
            child: CountryPickerUtils.getDefaultFlagImage(country),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 2,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 20,
            child: Text("+${country.phoneCode}(${country.isoCode})"),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordResetButton() {
    return FadeAnimation(
      2.5,
      GestureDetector(
        onTap: () => resetPassword(),
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
              AppLocalizations.of(context)
                  .translate("reset_password")
                  .toUpperCase(),
              style: GlobalStyling.styleButtonPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return FadeAnimation(
      2.7,
      GestureDetector(
        onTap: () => navigateToLogin(),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text:
                  AppLocalizations.of(context).translate("already_registered"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: AppLocalizations.of(context).translate("to_login"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return FadeAnimation(
      2.8,
      GestureDetector(
        onTap: () => navigateToSignIn(),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: AppLocalizations.of(context).translate("no_account"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: AppLocalizations.of(context).translate("create_account"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
    );
  }

  resetPassword() async {
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
      _phoneNumber =
          "+" + _countryChoosed.phoneCode + _phoneNumberController.text.trim();

      _flutterOtp.sendOtp(_phoneNumberController.text.trim(), null, minvalue,
          maxvalue, "+" + _countryChoosed.phoneCode);

      showOneTimePasswordPage(_phoneNumber);
    }
  }

  Future showOneTimePasswordPage(String phonenumber) async {
    String enteredCode = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return OneTimePasswordPage(
            mobileNumber: phonenumber,
          );
        },
      ),
    );

    bool resultOtp = _flutterOtp.resultChecker(int.parse(enteredCode));
    if (resultOtp) {
      String message = buildMessage(enteredCode);

      _flutterOtp.sendOtp(_phoneNumberController.text.trim(), message, minvalue,
          maxvalue, "+" + _countryChoosed.phoneCode);

      ResetPassword resetPassword = new ResetPassword(
          _phoneNumber, _emailController.text.trim(), enteredCode);
      bool passwordReseted =
          await _authenticationService.resetPassword(resetPassword);

      if (passwordReseted) {
        MyNotification.showInfoFlushbar(
            context,
            AppLocalizations.of(context).translate('info'),
            AppLocalizations.of(context).translate('password_reseted_success'),
            Icon(
              Icons.info,
              size: 28,
              color: Colors.blue.shade300,
            ),
            Colors.blue.shade300,
            20);

        navigateToLogin();
      } else {
        MyNotification.showInfoFlushbar(
            context,
            AppLocalizations.of(context).translate('error'),
            AppLocalizations.of(context).translate('password_reseted_error'),
            Icon(
              Icons.error,
              size: 28,
              color: Colors.red.shade300,
            ),
            Colors.red.shade300,
            3);
      }
    } else {
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('error'),
          AppLocalizations.of(context).translate('error_validating_otp') +
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

  String buildMessage(String tempPassword) {
    return AppLocalizations.of(context).translate('temporary_password1') +
        " " +
        tempPassword +
        "\n" +
        "\n" +
        AppLocalizations.of(context).translate('temporary_password2') +
        "\n" +
        "\n" +
        AppLocalizations.of(context).translate('ePossa_signature');
  }

  void onGoogleSignIn() async {
    firebaseUser = await _handleGoogleSignIn();
    _emailController.text = firebaseUser.email;
    setState(() {});
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // Flag to check whether we are signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // get the credential to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      user = (await _auth.signInWithCredential(credential)).user;
    }

    return user;
  }

  navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  navigateToSignIn() {
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
