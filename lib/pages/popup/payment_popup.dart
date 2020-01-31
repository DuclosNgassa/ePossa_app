import 'dart:typed_data';

import 'package:epossa_app/animations/fade_animation.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class PaymentPopup extends StatefulWidget {
  @override
  _PaymentPopupState createState() => _PaymentPopupState();
}

class _PaymentPopupState extends State<PaymentPopup> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]))),
                    child: TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: "Phone number"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: "Montant"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the amount';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeAnimation(
              1.8,
              Center(
                child: Container(
                  //width: 120,
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue[800]),
                  child: RawMaterialButton(
                    onPressed: () => _scan(),
                    child: Center(
                      child: Text(
                        "Scan QR-Code",
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
              2,
              Center(
                child: Container(
                  //width: 120,
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blue[800]),
                  child: RawMaterialButton(
                    onPressed: () => _scanPhoto(),
                    child: Center(
                      child: Text(
                        "Scan Photo",
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
              2,
              Center(
                child: Container(
                  //width: 120,
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green[800]),
                  child: RawMaterialButton(
                    onPressed: () => _submit(),
                    child: Center(
                      child: Text(
                        "Valider",
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
        ],
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState((){
      this.barcode = barcode;
      phoneNumberController.text = barcode;
    });
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState((){
      this.barcode = barcode;
      phoneNumberController.text = barcode;
    });
  }

  Future _submit() async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
    }
  }
}
