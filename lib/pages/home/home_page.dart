import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5,
            top: SizeConfig.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FadeAnimation(
              1.3,
              Text(
                AppLocalizations.of(context).translate('home'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
