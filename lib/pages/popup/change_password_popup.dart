import 'package:epossa_app/animations/fade_animation.dart';
import 'package:flutter/material.dart';

import '../../password_helper.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildInputForm(),
          SizedBox(
            height: 40,
          ),
          _buildSaveButtons(),
          SizedBox(height: 20),
          _buildFooterMessage(),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return FadeAnimation(
      1.5,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        hintText: "Old Password"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your old Password';
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
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: "New Password"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your new Password';
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
                        hintStyle:
                            TextStyle(color: Colors.grey.withOpacity(.8)),
                        hintText: "Confirm New Password"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your new Password again';
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            //width: 120,
            height: 50,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(51, 51, 153, 1),
            ),
            child: RawMaterialButton(
              onPressed: () => _save(),
              child: Center(
                child: Text(
                  "Save",
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
      padding: const EdgeInsets.all(20.0),
      child: FadeAnimation(
        2.3,
        Center(
          child: Text("Entrez votre nouveau mot de passe."),
        ),
      ),
    );
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String _checkPassword() {
    if (!PasswordHelper.checkEqualPassword(
        _newPassword1Controller.text, _newPassword2Controller.text)) {
      return 'Password1 and password 2 are different. Please correct them.';
    }
    return null;
  }

  Future<void> _save() async {}
}
