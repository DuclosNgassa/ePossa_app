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

    if (icon != null) {
      return buildButtonWithIcon();
    }
    return buildButtonWithoutIcon();
  }

  Widget buildButtonWithoutIcon() {
    return Container(
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: fillColor,
        splashColor: splashColor,
        shape: const StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtonWithIcon() {
    return Container(
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: fillColor,
        splashColor: splashColor,
        shape: const StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Text(
                text,
                style: textStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
