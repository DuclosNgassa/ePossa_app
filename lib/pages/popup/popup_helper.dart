import 'package:epossa_app/styling/global_color.dart';
import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'controller/popup_content.dart';
import 'controller/popup_layout.dart';

class PopupHelper {
  static showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    Navigator.push(
      context,
      PopupLayout(
        top: SizeConfig.blockSizeVertical * 4,
        left: SizeConfig.blockSizeHorizontal * 6,
        right: SizeConfig.blockSizeHorizontal * 6,
        bottom: SizeConfig.blockSizeVertical * 6,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              backgroundColor: GlobalColor.colorPrimary,
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }
}
