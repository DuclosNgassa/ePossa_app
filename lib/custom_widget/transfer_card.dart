import 'package:epossa_app/converter/date_converter.dart';
import 'package:epossa_app/model/transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TransferCard extends StatefulWidget {
  final Transfer transfer;
  final bool isReceiver;

  TransferCard({this.transfer, this.isReceiver});

  @override
  _TransferCardState createState() =>
      _TransferCardState(this.transfer, this.isReceiver);
}

class _TransferCardState extends State<TransferCard> {
  Transfer transfer;
  bool isReceiver;

  _TransferCardState(this.transfer, this.isReceiver);

  static final baseTextStyle = const TextStyle(fontFamily: 'Poppins');

  final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

  static final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 16,
      fontWeight: FontWeight.w400);

  final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    String _receiverTitle = 'Bénéficiaire';
    String _receiver = widget.transfer.phone_number_receiver;

    String _senderTitle = 'Expéditeur';
    String _sender = widget.transfer.phone_number_sender;

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: isSendingAndDescriptionNotEmpty() ? 300 : 250,
        margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(143, 148, 251, .3),
              blurRadius: 20.0,
              offset: Offset(0.0, 10.0),
            )
          ],
          color: new Color(0xFF333366),
        ),
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 4.0,
            ),
            new Text(
              'Montant: ' + widget.transfer.amount.toString() + ' FCFA',
              style: headerTextStyle,
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
              widget.isReceiver ? _senderTitle : _receiverTitle,
              style: headerTextStyle,
            ),
            SizedBox(height: 5),
            new Text(
              widget.isReceiver ? _sender : _receiver,
              style: subHeaderTextStyle,
            ),
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 100.0,
              color: new Color(0xff00c6ff),
            ),
            new Text(
              'Date de Transfert',
              style: headerTextStyle,
            ),
            SizedBox(height: 5),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.calendar_today),
                SizedBox(
                  width: 10,
                ),
                new Text(
                  DateConverter.convertToString(
                      widget.transfer.created_at, context),
                  style: subHeaderTextStyle,
                ),
              ],
            ),
            isSendingAndDescriptionNotEmpty()
                ? new Container(
                    margin: new EdgeInsets.symmetric(vertical: 8.0),
                    height: 2.0,
                    width: 100.0,
                    color: new Color(0xff00c6ff),
                  )
                : new Container(
                    height: 0,
                    width: 0,
                  ),
            isSendingAndDescriptionNotEmpty()
                ? Text(
                    'Description',
                    style: headerTextStyle,
                  )
                : Container(
                    width: 0,
                    height: 0,
                  ),
            isSendingAndDescriptionNotEmpty()
                ? buildDesscription()
                : Container(
                    width: 0,
                    height: 0,
                  ),
          ],
        ),
      ),
    );
  }

  bool isSendingAndDescriptionNotEmpty() {
    return (!widget.isReceiver) &&
        (widget.transfer.description != null &&
            widget.transfer.description.isNotEmpty);
  }

  Widget buildDesscription() {
    return Expanded(
      child: new Text(
        widget.transfer.description,
        style: subHeaderTextStyle,
      ),
    );
  }
}
