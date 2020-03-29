import 'package:epossa_app/animations/fade_animation.dart';
import 'package:epossa_app/custom_widget/custom_button.dart';
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
      body: buildListTile(),
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
        Container(
          width: SizeConfig.screenWidth * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2),
            child: FadeAnimation(
              1.5,
              CustomButton(
                fillColor: GlobalColor.colorButtonPrimary,
                splashColor: GlobalColor.colorWhite,
                iconColor: GlobalColor.colorWhite,
                text:
                    AppLocalizations.of(context).translate('other_questions') +
                        ' ' +
                        AppLocalizations.of(context).translate('contact_us'),
                textStyle: GlobalStyling.styleButtonWhite,
                onPressed: () => showContactPage(),
              ),
            ),
          ),
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
