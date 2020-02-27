import 'package:epossa_app/util/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../popup_content.dart';
import '../popup_layout.dart';

class PopupHelper {
  static showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    SizeConfig().init(context);

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
              backgroundColor: Color.fromRGBO(112, 139, 245, 1),
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
