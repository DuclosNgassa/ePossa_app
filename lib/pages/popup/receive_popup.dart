import 'dart:ui';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/services/sharedpreferences_service.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceivePopup extends StatefulWidget {
  @override
  _ReceivePopupState createState() => _ReceivePopupState();
}

class _ReceivePopupState extends State<ReceivePopup> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey globalKey = new GlobalKey();

  final String stars = "***";
  final amountController = TextEditingController();
  SharedPreferenceService _sharedPreferenceService =
      new SharedPreferenceService();

  String _phoneNumber;
  String _barCode = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    amountController.dispose();
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
            _displayQRCode(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            _builAmountInput(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            _buildQRCodeButtons(),
            _buildFooterMessage(),
          ],
        ),
      ),
    );
  }

  Widget _displayQRCode() {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
      child: FadeAnimation(
        1.2,
        Center(
          child: RepaintBoundary(
            key: globalKey,
            child: QrImage(
              data: _barCode,
              size: 0.3 * SizeConfig.screenHeight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _builAmountInput() {
    return FadeAnimation(
      1.5,
      Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5),
          child: Container(
            padding: EdgeInsets.all(5),
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
            child: Container(
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.attach_money),
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(.8),
                  ),
                  hintText: AppLocalizations.of(context).translate('amount'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodeButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 3,
          horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        1.8,
        Center(
          child: Container(
            height: SizeConfig.blockSizeVertical * 8,
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(51, 51, 153, 1)),
            child: RawMaterialButton(
              onPressed: () =>
                  _generateQRCodeWithAmount(int.parse(amountController.text)),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('qr_code_with_amount'),
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

  Widget _buildFooterMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical,
          horizontal: SizeConfig.blockSizeHorizontal * 5),
      child: FadeAnimation(
        2.1,
        Center(
          child: Text(
            AppLocalizations.of(context)
                .translate('scan_qrcode_to_receive_money'),
          ),
        ),
      ),
    );
  }

  Future<void> _generateQRCodeWithAmount(int amount) async {
    this.setState(() {
      this._barCode =
          _barCode = stars + _phoneNumber + stars + amount.toString() + stars;
    });
  }

  void _loadPhoneNumber() async {
    _phoneNumber = await _sharedPreferenceService.read(USER_PHONE);

    setState(() {
      this._barCode = _phoneNumber;
    });
  }
}
