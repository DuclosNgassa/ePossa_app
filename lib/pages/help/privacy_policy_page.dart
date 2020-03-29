import 'package:epossa_app/localization/app_localizations.dart';
import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:epossa_app/util/constant_field.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => new _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

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
        backgroundColor: GlobalColor.colorSecondary,
        title: _buildTitle(),
        automaticallyImplyLeading: false,
      ),
      body: buildBody(),
    );
  }

  _buildTitle() {
    return Text(AppLocalizations.of(context).translate('privacy_policy'));
  }

  Widget buildBody() {
    return WebView(
      initialUrl: PRIVACY_POLICY_URL,
    );
  }
}
