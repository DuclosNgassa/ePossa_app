import 'dart:typed_data';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ReceivePopup extends StatefulWidget {
  @override
  _ReceivePopupState createState() => _ReceivePopupState();
}

class _ReceivePopupState extends State<ReceivePopup> {
  String barcode = '';
  Uint8List barCode = Uint8List(200);
  static const String stars = "***";
  @override
  void initState() {
    super.initState();
    _generateBarCode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FadeAnimation(
            1.5,
            SizedBox(
              width: 200,
              height: 200,
              child: Image.memory(barCode),
            ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeAnimation(
              1.8,
              Center(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue[800]),
                  child: RawMaterialButton(
                    onPressed: () => _generateBarCodeWithAmount(5000),
                    child: Center(
                      child: Text(
                        "Generate Barcode with amount",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeAnimation(
              1.8,
              Center(
                child: Text("Faites scanner votre QR-Code afin de recevoir votre argent."),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _generateBarCode() async {
    Uint8List result = await scanner.generateBarCode(stars + '65767879067' + stars);
    this.setState(() => this.barCode = result);
  }

  Future _generateBarCodeWithAmount(int amount) async {
    Uint8List result = await scanner.generateBarCode(stars + '65767879067' + stars + amount.toString() + stars);
    this.setState(() => this.barCode = result);
  }
}
