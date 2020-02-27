import 'package:epossa_app/converter/date_converter.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/transfer.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/styling/styling.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Styling().init(context);

    return Column(
      children: <Widget>[
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: isSendingAndDescriptionNotEmpty() ? 380 : 250,
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
      ],
    );
  }

  Widget _buildCard() {
    String _receiverTitle = AppLocalizations.of(context).translate('receiver');
    String _receiver = widget.transfer.phone_number_receiver;

    String _senderTitle = AppLocalizations.of(context).translate('sender');
    ;
    String _sender = widget.transfer.phone_number_sender;

    return new Column(
      children: <Widget>[
        SizedBox(
          height: 4.0,
        ),
        new Text(
          AppLocalizations.of(context).translate('amount'),
          style: Styling.headerTextStyle,
        ),
        new Text(
          widget.transfer.amount.toString() + ' FCFA',
          style: Styling.subHeaderTextStyle,
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
          style: Styling.headerTextStyle,
        ),
        SizedBox(height: 5),
        new Text(
          widget.isReceiver ? _sender : _receiver,
          style: Styling.subHeaderTextStyle,
        ),
        new Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 100.0,
          color: new Color(0xff00c6ff),
        ),
        new Text(
          AppLocalizations.of(context).translate('transfer_date'),
          style: Styling.headerTextStyle,
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
              style: Styling.subHeaderTextStyle,
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
                AppLocalizations.of(context).translate('description'),
                style: Styling.headerTextStyle,
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
        style: Styling.subHeaderTextStyle,
      ),
    );
  }
}
