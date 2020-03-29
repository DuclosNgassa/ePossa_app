import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => new _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    return Scaffold(
      backgroundColor: GlobalColor.colorPrimary,
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 5,
                right: SizeConfig.blockSizeHorizontal * 5,
                top: SizeConfig.blockSizeVertical * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal),
                  child: new Container(
                    constraints: BoxConstraints.expand(
                        height: SizeConfig.screenHeight * 0.9),
                    child: buildListTile(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildListTile() {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildIcon(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          Expanded(
            child: buildAboutUsText(),
          ),
          buildVisitUsButton(),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 2,
          ),
        ],
      ),
    );
  }

  Widget buildIcon() {
    return FadeAnimation(
      1.3,
      Container(
        //height: SizeConfig.screenHeight * 0.4,
        child: Image.asset(
          "assets/images/kmerconsulting.png",
        ),
      ),
    );
  }

  Widget buildAboutUsText() {
    return FadeAnimation(
      1.5,
      Padding(
        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
        child: Text(
          AppLocalizations.of(context).translate('about_us_text'),
          style: GlobalStyling.styleNormalWhite,
        ),
      ),
    );
  }

  Widget buildVisitUsButton() {
    return FadeAnimation(
      1.7,
      Container(
        height: SizeConfig.blockSizeVertical * 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GlobalColor.colorButtonPrimary,
        ),
        child: RawMaterialButton(
          onPressed: () => launch(SITE_WEB),
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate('visit_us'),
              style: TextStyle(
                  color: GlobalColor.colorWhite,
                  fontSize: SizeConfig.blockSizeHorizontal * 4,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans'),
            ),
          ),
        ),
      ),
    );
  }
}
