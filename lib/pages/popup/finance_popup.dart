import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/model/transfer_bilan.dart';
import 'package:epossa_app/notification/notification.dart';
import 'package:epossa_app/services/transfer_service.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/cupertino.dart';
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

  TransferService _transferService = new TransferService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
          child: FadeAnimation(
            1.3,
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 2),
              height: SizeConfig.screenHeight * 0.4,
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
    return FutureBuilder(
      future: _computeTransferBilan(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TransferBilan transferBilan = snapshot.data;
          return Column(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              new Text(
                AppLocalizations.of(context).translate('total_received_amount'),
                style: headerTextStyle,
              ),
              new Text(
                transferBilan.sumTransferReceived.toString() + ' FCFA',
                style: subHeaderTextStyle,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                height: SizeConfig.blockSizeVertical * 0.25,
                width: SizeConfig.screenWidth * 0.25,
                color: new Color(0xff00c6ff),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              new Text(
                AppLocalizations.of(context).translate('total_sent_amount'),
                style: headerTextStyle,
              ),
              new Text(
                transferBilan.sumTransferSent.toString() + ' FCFA',
                style: subHeaderTextStyle,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
                height: SizeConfig.blockSizeVertical * 0.25,
                width: SizeConfig.screenWidth * 0.25,
                color: new Color(0xff00c6ff),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 1.5,
              ),
              new Text(
                AppLocalizations.of(context).translate('difference'),
                style: headerTextStyle,
              ),
              new Text(
                transferBilan.difference.toString() + ' FCFA',
                style: subHeaderTextStyle,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          MyNotification.showInfoFlushbar(
              context,
              AppLocalizations.of(context).translate('error'),
              AppLocalizations.of(context).translate('error_loading'),
              Icon(
                Icons.info_outline,
                size: 28,
                color: Colors.redAccent,
              ),
              Colors.redAccent,
              3);
        }
        return Center(
          child: CupertinoActivityIndicator(
            radius: SizeConfig.blockSizeHorizontal * 5,
          ),
        );
      },
    );
  }

  Widget _buildFooterMessage() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 5,
          vertical: SizeConfig.blockSizeVertical * 4),
      child: FadeAnimation(
        1.6,
        Center(
          child: Text(
            AppLocalizations.of(context).translate('my_finance_status'),
          ),
        ),
      ),
    );
  }

  Future<TransferBilan> _computeTransferBilan() async {
    TransferBilan transferBilan = await _transferService.getTransferBilan();
    return transferBilan;
  }
}
