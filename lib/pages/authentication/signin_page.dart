import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/model/userRole.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/pages/authentication/login_page.dart';
import 'package:epossa_app/pages/authentication/reset_password_page.dart';
import 'package:epossa_app/pages/navigation/navigation_page.dart';
import 'package:epossa_app/services/authentication_service.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'one_time_password_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthenticationService _authenticationService = new AuthenticationService();
  FlutterOtp _flutterOtp = new FlutterOtp();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();
  UserService _userService = new UserService();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Country _countryChoosed;
  bool obscurePassword1;
  bool obscurePassword2;
  String _phoneNumber;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _password1Controller = new TextEditingController();
  TextEditingController _password2Controller = new TextEditingController();

  TextEditingController _codeController = new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _phoneNumberFocusNode;
  FocusNode _password1FocusNode;
  FocusNode _password2FocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = new FocusNode();
    _emailFocusNode = new FocusNode();
    _phoneNumberFocusNode = new FocusNode();
    _password1FocusNode = new FocusNode();
    _password2FocusNode = new FocusNode();
    obscurePassword1 = true;
    obscurePassword2 = true;
    _countryChoosed = CountryPickerUtils.getCountryByIsoCode('CM');
    _phoneNumber = "";
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    _codeController.dispose();
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
        child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _formKey,
                autovalidate: false,
                child: SingleChildScrollView(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
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

  Container _buildBackground() {
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
              1.5,
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
              1.7,
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
              1.9,
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
                  horizontal: SizeConfig.blockSizeVertical * 5,
                ),
                child: Column(
                  children: <Widget>[
                    _buildFormTitle(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 8,
                    ),
                    _buildSigninInput(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    _buildSigninButton(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    _buildLoginButton(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    _buildPasswordForgottenButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTitle() {
    return FadeAnimation(
      2.1,
      Center(
        child: Text(
          AppLocalizations.of(context).translate("signin"),
          style: TextStyle(
              color: GlobalColor.colorWhite,
              fontSize: SizeConfig.blockSizeHorizontal * 9,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSigninInput() {
    return FadeAnimation(
      2.3,
      Container(
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
              child: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _nameController,
                textInputAction: TextInputAction.next,
                focusNode: _nameFocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_nameFocusNode, _emailFocusNode);
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
                onTap: () => onGoogleSignIn(),
                autofocus: true,
                keyboardType: TextInputType.text,
                controller: _emailController,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(_emailFocusNode, _phoneNumberFocusNode);
                },
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: TextFormField(
                obscureText: obscurePassword1,
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
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on obscurePassword1 state choose the icon
                      obscurePassword1
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of obscurePassword1 variable
                      setState(() {
                        obscurePassword1 = !obscurePassword1;
                      });
                    },
                  ),
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
                obscureText: obscurePassword2,
                keyboardType: TextInputType.text,
                controller: _password2Controller,
                focusNode: _password2FocusNode,
                onFieldSubmitted: (term) {
                  //TODO doSignIn()
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on obscurePassword2 state choose the icon
                      obscurePassword2
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of obscurePassword2 variable
                      setState(() {
                        obscurePassword2 = !obscurePassword2;
                      });
                    },
                  ),
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                  hintText:
                      AppLocalizations.of(context).translate("password_repeat"),
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

  Widget _buildSigninButton() {
    return FadeAnimation(
      2.5,
      GestureDetector(
        onTap: () => _signIn(),
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
                  color: GlobalColor.colorWhite,
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
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

  Widget _buildPasswordForgottenButton() {
    return FadeAnimation(
      2.9,
      GestureDetector(
        onTap: () => _navigateToPasswordReset(),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: AppLocalizations.of(context).translate("forgot_password"),
              style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.w400),
            )
          ]),
        ),
      ),
    );
  }

  _signIn() async {
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
      //Validate password
      _phoneNumber =
          "+" + _countryChoosed.phoneCode + _phoneNumberController.text.trim();
      if (_password1Controller.text == _password2Controller.text) {
        User user = new User(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _phoneNumber,
            _password1Controller.text,
            "deviceToken" + _nameController.text,
            UserStatus.pending,
            UserRole.user,
            0,
            3);

        UserDTO createdUser = await _authenticationService.signin(user);

        if (createdUser != null) {
          _flutterOtp.sendOtp(_phoneNumberController.text.trim(), null, 100000,
              999999, "+" + _countryChoosed.phoneCode);

          showOneTimePasswordPage(_phoneNumber);
        } else {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context).translate('error_signin'),
              Icon(
                Icons.error,
                size: 28,
                color: Colors.red.shade300,
              ),
              Colors.red.shade300,
              2);
        }
      } else {
        MyNotification.showInfoFlushbar(
            context,
            AppLocalizations.of(context).translate('error'),
            AppLocalizations.of(context).translate('password_different'),
            Icon(
              Icons.error,
              size: 28,
              color: Colors.red.shade300,
            ),
            Colors.red.shade300,
            2);
      }
    }
  }

  navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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

  void onGoogleSignIn() async {
    firebaseUser = await _handleGoogleSignIn();
    _emailController.text = firebaseUser.email;
    setState(() {});
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
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
    print("Result Flutter OTP : ");
    print(resultOtp);
    if (resultOtp) {
      // log user in to receive jwt and make update on user status
      await LoginAndActivateUser();
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

  Future LoginAndActivateUser() async {
    // log user in to receive jwt and make update on user status
    bool login = await _authenticationService.login(
        _phoneNumber, _password1Controller.text);

    //Sometime the first login doesnt work
    if (!login) {
      login = await _authenticationService.login(
          _phoneNumber, _password1Controller.text);
    }
    if (login) {
      await updateUser(_phoneNumber);
      _navigateToStartPage();
    } else {
      print("Login failed, _navigateToStartPage() ");
      _navigateToLoginPage();
    }
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
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            textInputAction: TextInputAction.next,
            focusNode: _phoneNumberFocusNode,
            onFieldSubmitted: (term) {
              _fieldFocusChange(_phoneNumberFocusNode, _password1FocusNode);
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

  _navigateToLoginPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (Route<dynamic> route) => false);
  }

  _navigateToStartPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationPage(),
        ),
        (Route<dynamic> route) => false);
  }

  _navigateToPasswordReset() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }

  Future updateUser(String phoneNumber) async {
    UserDTO userDTO = await _userService.readByPhoneNumber(phoneNumber);
    await _sharedPreferenceService.saveUser(userDTO);

    userDTO.status = UserStatus.active;

    UserDTO updatedUser = await _userService.update(userDTO);
  }
}
