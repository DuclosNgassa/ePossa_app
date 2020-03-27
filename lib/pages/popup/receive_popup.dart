import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
//import 'package:qrscan/qrscan.dart' as scanner;

class ReceivePopup extends StatefulWidget {
  @override
  _ReceivePopupState createState() => _ReceivePopupState();
}

class _ReceivePopupState extends State<ReceivePopup> {
/*
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
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
      child: FadeAnimation(
        1.2,
        SizedBox(
          width: SizeConfig.blockSizeVertical * 30,
          height: SizeConfig.blockSizeVertical * 30,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeVertical * 8,
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(51, 51, 153, 1)),
                child: RawMaterialButton(
                  onPressed: () => _generateQRCodeWithAmount(
                      int.parse(amountController.text)),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('qr_code_with_amount'),
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
                height: SizeConfig.blockSizeVertical * 8,
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
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

  Future<void> _generateQRCode() async {
    Uint8List result = await scanner.generateBarCode(stars + '65767879067' + stars);
    this.setState(() => this.barCode = result);
  }

  Future<void> _generateQRCodeWithAmount(int amount) async {
    Uint8List result = await scanner.generateBarCode(stars + '65767879067' + stars + amount.toString() + stars);
    this.setState(() => this.barCode = result);
  }
*/

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: SizeConfig.screenHeight * 0.6,
          width: SizeConfig.screenWidth * 0.8,
          child: _contentWidget(),
/*
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
*/
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter a custom message",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      child: Text("SUBMIT"),
                      onPressed: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = null;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
/*                  onError: (ex) {
                    print("[QR] ERROR - $ex");
                    setState((){
                      _inputErrorText = "Error! Maybe your input value is too long?";
                    });
                  },
*/
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
