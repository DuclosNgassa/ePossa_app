import 'dart:convert';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/user.dart';
import 'package:epossa_app/model/userDto.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/user_service.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';

class ChangeNamePopup extends StatefulWidget {
  @override
  _ChangeNamePopupState createState() => _ChangeNamePopupState();
}

class _ChangeNamePopupState extends State<ChangeNamePopup> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = new TextEditingController();
  UserService _userService = new UserService();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _nameController.dispose();
    _nameFocusNode.dispose();
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
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    focusNode: _nameFocusNode,
                    onFieldSubmitted: (term) {
                      //Save form
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText:
                            AppLocalizations.of(context).translate('name')),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('name_please');
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
            AppLocalizations.of(context).translate('new_name'),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    String logedUserString = await _sharedPreferenceService.read(USER);
    Map userMap = jsonDecode(logedUserString);
    User logedUser = User.fromJsonPref(userMap);
    UserDto userDto = new UserDto.id(
        logedUser.id,
        _nameController.text,
        logedUser.phone,
        logedUser.password,
        logedUser.salt,
        logedUser.status,
        logedUser.balance,
        logedUser.rating,
        logedUser.salt);
    User updatedUser = await _userService.update(userDto);

    if (updatedUser != null) {
      await _sharedPreferenceService.save(USER, jsonEncode(updatedUser));
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('info'),
          AppLocalizations.of(context)
              .translate('name_changed_success_message'),
          Icon(
            Icons.info_outline,
            size: 28,
            color: Colors.blue.shade300,
          ),
          Colors.blue.shade300,
          2);

      _nameController.text = "";
      setState(() {});
    } else {
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('error'),
          AppLocalizations.of(context).translate('error_changing_name'),
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
