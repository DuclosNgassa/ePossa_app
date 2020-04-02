import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/pages/authentication/one_time_password_page.dart';
import 'package:epossa_app/pages/authentication/signin_page.dart';
import 'package:epossa_app/pages/navigation/navigation_page.dart';
import 'package:epossa_app/services/authentication_service.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp/flutter_otp.dart';

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
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();
  FlutterOtp _flutterOtp = new FlutterOtp();
  Country _countryChoosed;
  bool obscurePassword;
  String _phoneNumber;

  FocusNode _phoneNumberFocusNode;
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode = new FocusNode();
    _passwordFocusNode = new FocusNode();
    obscurePassword = true;
    _countryChoosed = CountryPickerUtils.getCountryByIsoCode('CM');
    _phoneNumber = "";
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
                obscureText: obscurePassword,
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (term) {
                  //TODO doLogin()
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: getPasswordSuffixIcon(),
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
              _fieldFocusChange(_phoneNumberFocusNode, _passwordFocusNode);
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

  Widget getPasswordSuffixIcon() {
    return IconButton(
      icon: Icon(
        // Based on obscurePassword1 state choose the icon
        obscurePassword ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: () {
        // Update the state i.e. toogle the state of obscurePassword1 variable
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
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
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
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

  Widget _buildPasswordForgottenButton() {
    return FadeAnimation(
      3.1,
      GestureDetector(
        onTap: () => openPasswordForgotten(),
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

  _login() async {
    final FormState form = _formKey.currentState;
    _phoneNumber =
        "+" + _countryChoosed.phoneCode + _phoneNumberController.text.trim();

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
          _phoneNumber, _passwordController.text);

      if (login) {
        UserDTO userDTO = await _userService.readByPhoneNumber(_phoneNumber);
        if (isUserActive(userDTO)) {
          await _sharedPreferenceService.saveUser(userDTO);
          _navigateToStartPage();
        } else if (isUserPending(userDTO)) {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('info'),
              AppLocalizations.of(context).translate('validate_phone_number'),
              Icon(
                Icons.info,
                size: 28,
                color: Colors.blue.shade300,
              ),
              Colors.blue.shade300,
              3);

          _flutterOtp.sendOtp(_phoneNumberController.text.trim(), null, 100000,
              999999, "+" + _countryChoosed.phoneCode);

          showOneTimePasswordPage("+" +
              _countryChoosed.phoneCode +
              _phoneNumberController.text.trim());
        } else {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context).translate('account_blocked'),
              Icon(
                Icons.info,
                size: 28,
                color: Colors.red.shade300,
              ),
              Colors.red.shade300,
              5);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OneTimePasswordPage(
                mobileNumber: _phoneNumberController.text,
              ),
            ),
          );
        }
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

  bool isUserActive(UserDTO userDTO) {
    return userDTO.status == UserStatus.active;
  }

  bool isUserPending(UserDTO userDTO) {
    return userDTO.status == UserStatus.pending;
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
        _phoneNumber, _passwordController.text);
    //Sometime the first login doesnt work
    if (!login) {
      login = await _authenticationService.login(
          _phoneNumber, _passwordController.text);
    }
    if (login) {
      await updateUser(_phoneNumber);
      _navigateToStartPage();
    } else {
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

  Future updateUser(String phoneNumber) async {
    UserDTO userDTO = await _userService.readByPhoneNumber(phoneNumber);
    await _sharedPreferenceService.saveUser(userDTO);

    userDTO.status = UserStatus.active;

    UserDTO updatedUser = await _userService.update(userDTO);
  }

  openPasswordForgotten() {
    //TODO implements me please
  }
}
