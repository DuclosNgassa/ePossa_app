import 'dart:typed_data';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PaymentPopup extends StatefulWidget {
  @override
  _PaymentPopupState createState() => _PaymentPopupState();
}

class _PaymentPopupState extends State<PaymentPopup> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);
  static const String stars = "***";

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  FocusNode _phoneFocusNode;
  FocusNode _amountFocusNode;
  FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode = new FocusNode();
    _amountFocusNode = new FocusNode();
    _descriptionFocusNode = new FocusNode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    _phoneNumberController.dispose();
    _amountController.dispose();
    _phoneFocusNode.dispose();
    _amountFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildInputForm(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            _buildQrCodeButton(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            _buildQrCodeGalleryButton(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            _buildTransferButton(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 5,
                vertical: SizeConfig.blockSizeVertical * 2,
              ),
              child: _buildFooterMessage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm() {
    return FadeAnimation(
      1.5,
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 5,
            vertical: SizeConfig.blockSizeVertical),
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
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]),
                    ),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    focusNode: _phoneFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(_phoneFocusNode, _amountFocusNode);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.phone_iphone),
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText: AppLocalizations.of(context)
                          .translate('receiver_phonenumber'),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('receiver_phonenumber_please');
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
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _amountFocusNode,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          _amountFocusNode, _descriptionFocusNode);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.attach_money),
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText:
                          AppLocalizations.of(context).translate('amount'),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalizations.of(context)
                            .translate('transfer_amount_please');
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  child: TextFormField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onFieldSubmitted: (term) {
                      _descriptionFocusNode.unfocus();
                      //_submitForm();
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText:
                          AppLocalizations.of(context).translate('description'),
                    ),
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            //width: 120,
            height: SizeConfig.blockSizeVertical * 6,
            //padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, 6),
              ]),
            ),
            child: RawMaterialButton(
              onPressed: () => _scan(),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('scan_qr_code'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
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

  Widget _buildQrCodeGalleryButton() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            //width: 120,
            height: SizeConfig.blockSizeVertical * 6,
            //padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, 6),
              ]),
            ),
            child: RawMaterialButton(
              onPressed: () => _scanPhoto(),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)
                      .translate('scan_qr_code_gallery'),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
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

  Widget _buildTransferButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            //width: 120,
            height: SizeConfig.blockSizeVertical * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromRGBO(51, 51, 153, 1),
            ),
            child: RawMaterialButton(
              onPressed: () => _submit(),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('transfer'),
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
    return FadeAnimation(
      2.3,
      Center(
        child: Text(
          AppLocalizations.of(context).translate('scan_for_transfer'),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      this.barcode = barcode;
      _phoneNumberController.text = _getPhoneNumberFromQRCode(barcode);
    });
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() {
      this.barcode = barcode;
      _phoneNumberController.text = _getPhoneNumberFromQRCode(barcode);
    });
  }

  Future _submit() async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Processing Data'),
        ),
      );
    }
  }

  String _getPhoneNumberFromQRCode(String qrCode) {
    List<String> phoneNumbers = qrCode.split(stars);
    if (phoneNumbers.isEmpty) {
      return "";
    }

    return phoneNumbers[1];
  }

  int _getAmountFromQRCode(String qrCode) {
    List<String> amounts = qrCode.split(stars);
    if (amounts.isEmpty || amounts.length < 2) {
      return 0;
    }

    return int.parse(amounts[2]);
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
