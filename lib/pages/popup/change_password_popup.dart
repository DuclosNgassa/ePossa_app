import 'dart:convert';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/model/userPassword.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordPopup extends StatefulWidget {
  @override
  _ChangePasswordPopupState createState() => _ChangePasswordPopupState();
}

class _ChangePasswordPopupState extends State<ChangePasswordPopup> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newPassword1Controller = new TextEditingController();
  TextEditingController _newPassword2Controller = new TextEditingController();
  TextEditingController _oldPasswordController = new TextEditingController();
  UserService _userService = new UserService();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  FocusNode _newPassword1FocusNode;
  FocusNode _newPassword2FocusNode;
  FocusNode _oldPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _newPassword1FocusNode = new FocusNode();
    _newPassword2FocusNode = new FocusNode();
    _oldPasswordFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _newPassword1Controller.dispose();
    _newPassword2Controller.dispose();
    _oldPasswordController.dispose();
    _newPassword1FocusNode.dispose();
    _newPassword2FocusNode.dispose();
    _oldPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildInputForm(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 8,
          ),
          _buildSaveButtons(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          _buildFooterMessage(),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return FadeAnimation(
      1.5,
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 5,
        ),
        child: Form(
          key: _formKey,
          child: Container(
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
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    controller: _oldPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _oldPasswordFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          _oldPasswordFocusNode, _newPassword1FocusNode);
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: AppLocalizations.of(context)
                            .translate('old_password')),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('old_password_please');
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                  child: TextFormField(
                    obscureText: true,
                    controller: _newPassword1Controller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _newPassword1FocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          _newPassword1FocusNode, _newPassword2FocusNode);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: AppLocalizations.of(context)
                          .translate('new_password'),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('new_password');
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                  child: TextFormField(
                    obscureText: true,
                    controller: _newPassword2Controller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _newPassword2FocusNode,
                    onFieldSubmitted: (term) {
                      //Save form
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: AppLocalizations.of(context)
                          .translate('confirm_new_password'),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('new_password_again');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButtons() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            height: SizeConfig.blockSizeVertical * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(51, 51, 153, 1),
            ),
            child: RawMaterialButton(
              onPressed: () => _save(),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('save'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 5,
          vertical: SizeConfig.blockSizeVertical * 4),
      child: FadeAnimation(
        2.3,
        Center(
          child: Text(
            AppLocalizations.of(context).translate('new_password_please'),
          ),
        ),
      ),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<void> _save() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('error'),
          AppLocalizations.of(context).translate('correct_form_errors'),
          Icon(
            Icons.error,
            size: 28,
            color: Colors.red.shade300,
          ),
          Colors.red.shade300,
          2);
    } else {
      String logedUserString = await _sharedPreferenceService.read(USER);
      Map userMap = jsonDecode(logedUserString);
      UserDTO logedUser = UserDTO.fromJsonPref(userMap);

      if (_newPassword1Controller.text == _newPassword2Controller.text) {
        UserPassword userDto = new UserPassword(logedUser.phone,
            _oldPasswordController.text, _newPassword1Controller.text);

        bool successfulChange = await _userService.changePassword(userDto);

        if (successfulChange) {
          _clearForm();
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('info'),
              AppLocalizations.of(context)
                  .translate('password_changed_success_message'),
              Icon(
                Icons.info_outline,
                size: 28,
                color: Colors.blue.shade300,
              ),
              Colors.blue.shade300,
              2);
        } else {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context).translate('error_changing_password'),
              Icon(
                Icons.error,
                size: 28,
                color: Colors.red.shade300,
              ),
              Colors.red.shade300,
              2);
          return null;
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

        return null;
      }
    }
  }

  void _clearForm() {
    _oldPasswordController.text = "";
    _newPassword1Controller.text = "";
    _newPassword2Controller.text = "";
    setState(() {});
  }
}
