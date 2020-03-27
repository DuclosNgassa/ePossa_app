import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/help/privacy_policy_page.dart';
import 'package:epossa_app/pages/help/share_page.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';

import 'about_us_page.dart';
import 'help_page.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                child: new Text(
                  AppLocalizations.of(context).translate('infos'),
                  style: GlobalStyling.styleTitleWhite,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 8),
          child: new Container(
            constraints:
                BoxConstraints.expand(height: SizeConfig.screenHeight * 0.70),
            child: buildListTile(),
          ),
        ),
      ],
    );
  }

  Widget buildListTile() {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight * 0.25,
            child: Image.asset(
              "assets/images/info.png",
            ),
          ),
          ListTile(
            onTap: () => showHelpPage(),
            leading: Icon(
              Icons.help,
              color: GlobalColor.colorWhite,
            ),
            title: Text(
              AppLocalizations.of(context).translate('how_it_works'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorWhite,
            ),
          ),
          Divider(
            height: SizeConfig.blockSizeVertical,
          ),
          ListTile(
            onTap: () => showSharePage(),
            leading: Icon(
              Icons.share,
              color: GlobalColor.colorWhite,
            ),
            title: Text(
              AppLocalizations.of(context).translate('inform_friends'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorWhite,
            ),
          ),
          Divider(
            height: SizeConfig.blockSizeVertical,
          ),
          ListTile(
            onTap: () => showAboutUsPage(),
            leading: Icon(
              Icons.sentiment_satisfied,
              color: GlobalColor.colorWhite,
            ),
            title: Text(
              AppLocalizations.of(context).translate('who_are_we'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorWhite,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () => showPrivacyPolicyPage(),
            leading: Icon(
              Icons.account_balance,
              color: GlobalColor.colorWhite,
            ),
            title: Text(
              AppLocalizations.of(context).translate('privacy_policy'),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: GlobalColor.colorWhite,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  // This is the builder method that creates a new page
  showHelpPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HelpPage();
        },
      ),
    );
  }

  // This is the builder method that creates a new page
  showSharePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SharePage();
        },
      ),
    );
  }

  showAboutUsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AboutUsPage();
        },
      ),
    );
  }

  showPrivacyPolicyPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PrivacyPolicyPage();
        },
      ),
    );
  }
}
