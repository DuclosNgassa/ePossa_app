import 'package:epossa_app/styling/global_styling.dart';
import 'package:epossa_app/styling/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.onPressed,
      @required this.fillColor,
      @required this.splashColor,
      this.icon,
      @required this.iconColor,
      @required this.text,
      @required this.textStyle});

  final GestureTapCallback onPressed;
  final Color fillColor;
  final Color splashColor;
  final Color iconColor;
  final IconData icon;
  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalStyling().init(context);

    return Container(
      width: SizeConfig.blockSizeHorizontal * 25,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: fillColor,
        splashColor: splashColor,
        shape: const StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            icon != null
                ? Padding(
                    padding:
                        EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                    child: Icon(
                      icon,
                      color: iconColor,
                    ),
                  )
                : Container(),
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
