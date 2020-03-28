import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/contact/contact_page.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'faq_page.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => new _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with TickerProviderStateMixin {
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
/*
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
*/
                Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 8),
                  child: new Container(
                    constraints: BoxConstraints.expand(
                        height: SizeConfig.screenHeight * 0.70),
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

  Widget _buildTitle() {
    return FadeAnimation(
      1.3,
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
        child: Text(
          AppLocalizations.of(context).translate('how_it_works'),
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
              child: Icon(FontAwesomeIcons.questionCircle, color: GlobalColor.colorWhite,
                  size: SizeConfig.screenHeight * 0.2)
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 10,
          ),
          FadeAnimation(
            1.7,
            ListTile(
              onTap: () => showFaqPage(),
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
          Divider(),
          FadeAnimation(
            1.5,
            ListTile(
              onTap: () => showContactPage(),
              leading: Icon(
                FontAwesomeIcons.comments,
                color: GlobalColor.colorWhite,
              ),
              title: Text(
                AppLocalizations.of(context).translate('contact_us'),
                style: GlobalStyling.styleTitleWhite,
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

  showFaqPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return FaqPage();
        },
      ),
    );
  }

  Future<void> showContactPage() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ContactPage();
        },
      ),
    );
  }
}
