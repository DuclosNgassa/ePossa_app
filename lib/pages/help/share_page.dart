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

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: GlobalColor.colorDeepPurple300,
        title: _buildTitle(),
        automaticallyImplyLeading: false,
      ),
      body: buildListTile(),
    );
  }

  _buildTitle() {
    return Text(AppLocalizations.of(context).translate('share'));
  }

  Widget buildListTile() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight * 0.54,
            child: Image.asset(
              "assets/gif/sharesocial.gif",
            ),
          ),
          ListTile(
            onTap: () => shareToWhatsapp(),
            leading: Icon(
              FontAwesomeIcons.whatsapp,
              color: Colors.green,
            ),
            title: Text("Whatsapp"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorGrey400,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () => shareToSystem(),
            leading: Icon(
              Icons.share,
              color: Colors.purple,
            ),
            title: Text(AppLocalizations.of(context).translate('others')),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorGrey400,
            ),
          ),
        ],
      ),
    );
  }

  void shareToWhatsapp() {
    FlutterShareMe().shareToWhatsApp(
        base64ImageUrl: "http://www.whatsapp.de", msg: APP_URL);
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
