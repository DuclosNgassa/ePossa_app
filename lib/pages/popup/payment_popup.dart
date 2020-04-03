import 'dart:typed_data';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/model/transferDto.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/services/transfer_service.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';

class PaymentPopup extends StatefulWidget {
  @override
  _PaymentPopupState createState() => _PaymentPopupState();
}

class _PaymentPopupState extends State<PaymentPopup> {
  TransferService _transferService = new TransferService();

  String barcode = '';
  Uint8List bytes = Uint8List(200);
  static const String stars = "***";

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  Transfer newTransfer =
      new Transfer(0, DateTime.now(), "sender", "receiver", 0, "description");
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
    GlobalStyling().init(context);

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
            vertical: SizeConfig.blockSizeVertical * 5),
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
                    onSaved: (val) => newTransfer.receiver = val,
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
                    onSaved: (val) => newTransfer.amount = double.parse(val),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                  child: TextFormField(
                    controller: _descriptionController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                      hintText:
                          AppLocalizations.of(context).translate('description'),
                    ),
                    onFieldSubmitted: (term) {
                      _descriptionFocusNode.unfocus();
                    },
                    onSaved: (val) => newTransfer.description = val,
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
                      color: GlobalColor.colorWhite,
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
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2,
        Center(
          child: Container(
            //width: 120,
            height: SizeConfig.blockSizeVertical * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: GlobalColor.colorButtonPrimary,
            ),
            child: RawMaterialButton(
              onPressed: () => _submit(),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('transfer'),
                  style: GlobalStyling.styleButtonPrimary,
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
    String barcode = await BarcodeScanner.scan();
    setState(() {
      this.barcode = barcode;
      _fillForm(barcode);
    });
  }

  void _fillForm(String barcode) {
    if (barcode.contains(stars)) {
      _phoneNumberController.text = _getPhoneNumberFromQRCode(barcode);
      String amount = _getAmountFromQRCode(barcode).toString();
      _amountController.text = amount.isEmpty ? "0" : amount;
    } else {
      _phoneNumberController.text = barcode;
    }
  }

  Future _submit() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      MyNotification.showInfoFlushbar(
          context,
          AppLocalizations.of(context).translate('info'),
          AppLocalizations.of(context).translate('correct_form_errors'),
          Icon(
            Icons.info_outline,
            size: 28,
            color: Colors.red.shade300,
          ),
          Colors.red.shade300,
          2);
    } else {
      form.save();
      Transfer savedTransfer = await _saveTransfer();
      if (savedTransfer != null) {
        MyNotification.showInfoFlushbar(
            context,
            AppLocalizations.of(context).translate('info'),
            AppLocalizations.of(context)
                .translate('transfer_sent_success_message'),
            Icon(
              Icons.info_outline,
              size: 28,
              color: Colors.blue.shade300,
            ),
            Colors.blue.shade300,
            2);
        _clearForm();
      }
    }
  }

  _clearForm() {
    _formKey.currentState?.reset();
    _phoneNumberController.text = "";
    _amountController.text = "";
    _descriptionController.text = "";
    setState(() {});
  }

  String _getPhoneNumberFromQRCode(String qrCode) {
    List<String> phoneNumbers = qrCode.split(stars);
    if (phoneNumbers.isEmpty) {
      return "";
    }

    return phoneNumbers[1];
  }

  String _getAmountFromQRCode(String qrCode) {
    List<String> amounts = qrCode.split(stars);
    if (amounts.isEmpty || amounts.length < 2) {
      return "";
    }

    return amounts[2];
  }

  _fieldFocusChange(FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<Transfer> _saveTransfer() async {
    print(newTransfer);
    //DateTime dateTime = DateTime.now();
    String userPhone = await _sharedPreferenceService.read(USER_PHONE);

    TransferDTO transfer = new TransferDTO(
        userPhone,
        _phoneNumberController.text,
        double.parse(_amountController.text),
        _descriptionController.text);

    //Map<String, dynamic> transferDynamic = transfer.toJsonWithoutId();

    Transfer savedTransfer = await _transferService.create(transfer);
    return savedTransfer;
  }
}
