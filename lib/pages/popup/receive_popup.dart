import 'dart:typed_data';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ReceivePopup extends StatefulWidget {
  @override
  _ReceivePopupState createState() => _ReceivePopupState();
}

class _ReceivePopupState extends State<ReceivePopup> {
  final _formKey = GlobalKey<FormState>();
  final String stars = "***";
  final amountController = TextEditingController();

  String barcode = '';
  Uint8List barCode = Uint8List(200);

  @override
  void initState() {
    super.initState();
    _generateQRCode();
  }

  @override
  void dispose() {
    //Clean up the controller when the widget is disposed
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _displayQRCode(),
          SizedBox(
            height: 40,
          ),
          _builAmountInput(),
          SizedBox(
            height: 10,
          ),
          _buildQRCodeButtons(),
          _buildFooterMessage(),
        ],
      ),
    );
  }

  Widget _displayQRCode() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FadeAnimation(
        1.2,
        SizedBox(
          width: 200,
          height: 200,
          child: Image.memory(barCode),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]))),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.attach_money),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(.8),
                    ),
                    hintText: AppLocalizations.of(context).translate('amount'),),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQRCodeButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: FadeAnimation(
        1.8,
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(51, 51, 153, 1)),
                child: RawMaterialButton(
                  onPressed: () => _generateQRCodeWithAmount(
                      int.parse(amountController.text)),
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
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(51, 51, 153, 1)),
                child: RawMaterialButton(
                  onPressed: () => _generateQRCode(),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('qr_code'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: FadeAnimation(
        2.1,
        Center(
          child: Text(
              AppLocalizations.of(context).translate('scan_qrcode_to_receive_money'),),
        ),
      ),
    );
  }

  Future<void> _generateQRCode() async {
    Uint8List result =
        await scanner.generateBarCode(stars + '65767879067' + stars);
    this.setState(() => this.barCode = result);
  }

  Future<void> _generateQRCodeWithAmount(int amount) async {
    Uint8List result = await scanner.generateBarCode(
        stars + '65767879067' + stars + amount.toString() + stars);
    this.setState(() => this.barCode = result);
  }
}
