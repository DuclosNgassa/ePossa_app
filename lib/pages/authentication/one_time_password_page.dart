import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otp_input.dart';

class OneTimePasswordPage extends StatefulWidget {
  final String mobileNumber;

  OneTimePasswordPage({Key key, @required this.mobileNumber})
      : assert(mobileNumber != null),
        super(key: key);

  @override
  _OneTimePasswordPage createState() => _OneTimePasswordPage();
}

class _OneTimePasswordPage extends State<OneTimePasswordPage> {
  /// Control the input text field.
  TextEditingController _pinEditingController = TextEditingController();

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration =
      UnderlineDecoration(enteredColor: Colors.black, hintText: 'XXXXXX');
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final int CODE_LENGTH = 6;

  @override
  void initState() {
    super.initState();
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
                    buildPinInputTextField(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    buildValidateButton(),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPinInputTextField() {
    return PinInputTextField(
      pinLength: CODE_LENGTH,
      decoration: _pinDecoration,
      controller: _pinEditingController,
      autoFocus: true,
      textInputAction: TextInputAction.done,
      onSubmit: (pin) => validateInput(pin.length),
    );
  }

  Widget buildValidateButton() {
    return FadeAnimation(
      2.5,
      GestureDetector(
        onTap: () => validateInput(_pinEditingController.text.length),
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
              AppLocalizations.of(context).translate("validate").toUpperCase(),
              style: GlobalStyling.styleButtonPrimary,
            ),
          ),
        ),
      ),
    );
  }

  void validateInput(int inputLength) {
    if (inputLength == CODE_LENGTH) {
      _onFormSubmitted();
    } else {
      MyNotification.showInfoFlushbar(
        context,
        AppLocalizations.of(context).translate('error'),
        AppLocalizations.of(context).translate('code_invalid'),
        Icon(
          Icons.error,
          size: 28,
          color: Colors.red.shade300,
        ),
        Colors.red.shade300,
        3,
      );
    }
  }

  Widget _buildFormTitle() {
    return FadeAnimation(
      2.1,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).translate('code_verification'),
                style: GlobalStyling.styleHeaderWhite,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 8,
              ),
              Text(
                AppLocalizations.of(context).translate('code_sent_to') +
                    " " +
                    widget.mobileNumber,
                style: GlobalStyling.styleTitleBlack,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onFormSubmitted() {
    Navigator.of(context).pop(_pinEditingController.text);
  }
}
