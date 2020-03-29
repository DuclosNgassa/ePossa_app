import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/pages/contact/contact_page.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => new _FaqPageState();
}

class _FaqPageState extends State<FaqPage> with TickerProviderStateMixin {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    return Scaffold(
      backgroundColor: GlobalColor.colorPrimary,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('how_it_works')),
        backgroundColor: GlobalColor.colorSecondary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 2),
        child: buildListTile(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget buildListTile() {
    return Column(
      children: <Widget>[
        Expanded(
          child: buildListFaq(),
        ),
        Divider(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        buildContactButton(),
        Divider(
          height: SizeConfig.blockSizeVertical * 2,
        ),
      ],
    );
  }

  Widget buildListFaq() {
    return FadeAnimation(
      1.3,
      ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq1'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp1'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq2'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp2'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq3'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp3'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq4'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp4'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq5'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp5'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              AppLocalizations.of(context).translate('faq6'),
              style: GlobalStyling.styleNormalWhite,
            ),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                child: Text(
                  AppLocalizations.of(context).translate('resp6'),
                  style: GlobalStyling.styleNormalBlack,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContactButton() {
    return FadeAnimation(
      1.5,
      Container(
        height: SizeConfig.blockSizeVertical * 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: GlobalColor.colorButtonPrimary,
        ),
        child: RawMaterialButton(
          onPressed: () => showContactPage(),
          child: Center(
            child: Text(
              AppLocalizations.of(context).translate('other_questions') +
                  ' ' +
                  AppLocalizations.of(context).translate('contact_us'),
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

  showContactPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ContactPage();
        },
      ),
    );
  }
}
