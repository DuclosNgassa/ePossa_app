import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/model/user_status.dart';
import 'package:epossa_app/pages/navigation/navigation_page.dart';
import 'package:epossa_app/services/authentication_service.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'otp_input.dart';

class OTPPage extends StatefulWidget {
  final String mobileNumber;
  final String password;

  OTPPage({Key key, @required this.mobileNumber, this.password})
      : assert(mobileNumber != null),
        super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();
  UserService _userService = new UserService();
  AuthenticationService _authenticationService = new AuthenticationService();

  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: '333333');

  bool isCodeSent = false;
  String _verificationId;

  @override
  void initState() {
    super.initState();
    _onVerifyCode();
  }

  @override
  Widget build(BuildContext context) {
    print("isValid - $isCodeSent");
    print("mobiel ${widget.mobileNumber}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 16, top: 4),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Verify Details",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "OTP sent to ${widget.mobileNumber}",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(100),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinInputTextField(
                pinLength: 6,
                decoration: _pinDecoration,
                controller: _pinEditingController,
                autoFocus: true,
                textInputAction: TextInputAction.done,
                onSubmit: (pin) {
                  if (pin.length == 6) {
                    _onFormSubmitted();
                  } else {
                    print("Invalid OTP");
                    //showToast("Invalid OTP", Colors.red);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0)),
                    child: Text(
                      "ENTER OTP",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_pinEditingController.text.length == 6) {
                        _onFormSubmitted();
                      } else {
                        print("Invalid OTP");
                        //showToast("Invalid OTP", Colors.red);
                      }
                    },
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((AuthResult value) async {
        if (value.user != null) {
          // log user in to receive jwt and make update on user status
          if (widget.password != null && widget.password.isNotEmpty) {
            bool login = await _authenticationService.login(
                widget.mobileNumber, widget.password);
            login = await _authenticationService.login(
                widget.mobileNumber, widget.password);
            if (login) {
              print(value.user.phoneNumber);
              await updateUser(value.user.phoneNumber);
              _navigateToStartPage();
            } else {
              print("Error validating OTP, try again");
              _navigateToLoginPage();
            }
          } else {
            print("Error validating OTP, try again");
            _navigateToLoginPage();
          }
        } else {
          print("Error validating OTP, try again");
          //showToast("Error validating OTP, try again", Colors.red);
        }
      }).catchError((error) {
        print("Try again in sometime");
        //showToast("Try again in sometime", Colors.red);
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print(authException.message);
      //showToast(authException.message, Colors.red);
      setState(() {
        isCodeSent = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.mobileNumber}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }


  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _pinEditingController.text);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult value) async {
      if (value.user != null) {
        // log user in to receive jwt and make update on user status
        if (widget.password != null && widget.password.isNotEmpty) {
          bool login = await _authenticationService.login(
              widget.mobileNumber, widget.password);
          login = await _authenticationService.login(
              widget.mobileNumber, widget.password);
          if (login) {
            print(value.user.phoneNumber);
            await updateUser(value.user.phoneNumber);
            _navigateToStartPage();
          } else {
            print("Error validating OTP, try again");
            _navigateToLoginPage();
          }
        } else {
          print("Error validating OTP, try again");
          _navigateToLoginPage();
        }
      } else {
        print("Error validating OTP, try again");
        //showToast("Error validating OTP, try again", Colors.red);
      }
    }).catchError((error) {
      print("Something went wrong");
      //showToast("Something went wrong", Colors.red);
    });
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

  Future updateUser(String phoneNumber) async {
    UserDTO userDTO = await _userService.readByPhoneNumber(phoneNumber);
    await _sharedPreferenceService.saveUser(userDTO);

    userDTO.status = UserStatus.active;

    UserDTO updatedUser = await _userService.update(userDTO);
  }
}
