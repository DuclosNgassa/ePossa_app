import 'package:epossa_app/animations/fade_animation.dart';
import 'package:flutter/material.dart';

class FinancePopup extends StatefulWidget {
  @override
  _FinancePopupState createState() => _FinancePopupState();
}

class _FinancePopupState extends State<FinancePopup> {
  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

  final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  static final regularTextStyle = baseTextStyle.copyWith(
      color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w400);

  final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: FadeAnimation(
            1.3,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 250,
              //margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .3),
                    blurRadius: 20.0,
                    offset: Offset(0.0, 10.0),
                  )
                ],
                color: Color.fromRGBO(128, 212, 255, .3),

                //color: new Color(0xFF333366),
              ),
              child: _buildCard(),
            ),
          ),
        ),
        _buildFooterMessage()
      ],
    );
  }

  Widget _buildCard() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 4.0,
        ),
        new Text(
          'Total montant recu',
          style: headerTextStyle,
        ),
        new Text(
          "55000" + ' FCFA',
          style: subHeaderTextStyle,
        ),
        new Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 100.0,
          color: new Color(0xff00c6ff),
        ),
        SizedBox(
          height: 10.0,
        ),
        new Text(
          'Total montant envoyé',
          style: headerTextStyle,
        ),
        new Text(
          "25000" + ' FCFA',
          style: subHeaderTextStyle,
        ),
        new Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 100.0,
          color: new Color(0xff00c6ff),
        ),
        SizedBox(
          height: 10.0,
        ),
        new Text(
          'Differance',
          style: headerTextStyle,
        ),
        new Text(
          "30000" + ' FCFA',
          style: subHeaderTextStyle,
        ),
      ],
    );
  }

  Widget _buildFooterMessage() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FadeAnimation(
        1.6,
        Center(
          child: Text("Etat de mes finances"),
        ),
      ),
    );
  }
}
