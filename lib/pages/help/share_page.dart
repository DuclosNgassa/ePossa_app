import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => new _SharePageState();
}

class _SharePageState extends State<SharePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String userEmail;
  String userName;

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
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 8),
                  child: new Container(
                    constraints: BoxConstraints.expand(
                        height: SizeConfig.screenHeight * 0.90),
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
    return Container(
      child: ListView(
        children: <Widget>[
          FadeAnimation(
            1.3,
            Container(
              height: SizeConfig.screenHeight * 0.47,
              child: Image.asset(
                "assets/gif/sharesocial.gif",
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 5,
          ),
          FadeAnimation(
            1.5,
            ListTile(
              onTap: () => shareToWhatsapp(),
              leading: Icon(
                FontAwesomeIcons.whatsapp,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                "Whatsapp",
                style: GlobalStyling.styleNormalWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            1.7,
            ListTile(
              onTap: () => shareToSystem(),
              leading: Icon(
                Icons.share,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('others'),
                style: GlobalStyling.styleNormalWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void shareToWhatsapp() {
    FlutterShareMe()
        .shareToWhatsApp(base64Image: "http://www.whatsapp.de", msg: APP_URL);
  }

  void shareToFacebook() {
    FlutterShareMe().shareToFacebook(url: APP_URL, msg: "ePossa app");
  }

  void shareToSystem() async {
    var response = await FlutterShareMe().shareToSystem(msg: APP_URL);
    if (response == 'success') {
      print('navigate success');
    }
  }

  void shareToTwitter() async {
    var response =
        await FlutterShareMe().shareToTwitter(url: APP_URL, msg: "ePossa app");
    if (response == 'success') {
      print('navigate success');
    }
  }
}
