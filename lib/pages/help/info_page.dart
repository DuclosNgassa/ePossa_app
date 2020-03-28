import 'package:epossa_app/animations/fade_animation.dart';
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
            Padding(
              padding:
                  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 5),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  _buildTitle(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 4),
              child: new Container(
                constraints: BoxConstraints.expand(
                    height: SizeConfig.screenHeight * 0.70),
                child: buildListTile(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
        child: new Text(
          AppLocalizations.of(context).translate('infos'),
          style: GlobalStyling.styleHeaderWhite,
        ),
      ),
    );
  }

  Widget buildListTile() {
    return Container(
      child: ListView(
        children: <Widget>[
          FadeAnimation(
            1.5,
            Container(
              height: SizeConfig.screenHeight * 0.25,
              child: Image.asset(
                "assets/images/info.png",
              ),
            ),
          ),
          FadeAnimation(
            1.7,
            ListTile(
              onTap: () => showHelpPage(),
              leading: Icon(
                Icons.help,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('how_it_works'),
                style: GlobalStyling.styleTitleWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          Divider(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            1.9,
            ListTile(
              onTap: () => showSharePage(),
              leading: Icon(
                Icons.share,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('inform_friends'),
                style: GlobalStyling.styleTitleWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          Divider(
            height: SizeConfig.blockSizeVertical,
          ),
          FadeAnimation(
            2.1,
            ListTile(
              onTap: () => showAboutUsPage(),
              leading: Icon(
                Icons.sentiment_satisfied,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('who_are_we'),
                style: GlobalStyling.styleTitleWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
            ),
          ),
          Divider(),
          FadeAnimation(
            2.3,
            ListTile(
              onTap: () => showPrivacyPolicyPage(),
              leading: Icon(
                Icons.account_balance,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('privacy_policy'),
                style: GlobalStyling.styleTitleWhite,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: GlobalColor.colorWhite,
              ),
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