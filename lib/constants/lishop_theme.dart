import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiShopColors {
  static const Color textDark = const Color(0xff131313);
  static const Color textLight = const Color(0xff606060);
  static const Color themeDark = const Color(0xFF1B1B1B);
  static const MaterialColor themeColor = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50:  Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static const int _bluePrimaryValue = 0xFF2196F3;

}


class LiShopTextStyle {
  static TextStyle lato900(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w900,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle lato700(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w700,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle lato300(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w300,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  ///Normal font
  static TextStyle lato400(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w400,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  ///Medium
  static TextStyle lato500(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w500,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle lato600(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      TextDecoration decoration,
      Color decorationColor}) {
    return lato(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w600,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle lato(
      {@required double fontSize,
      Color color: LiShopColors.themeColor,
      FontWeight fontWeight: FontWeight.w900,
      TextDecoration decoration,
      Color decorationColor}) {
    return GoogleFonts.lato(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor);
  }
}

class LiShopSpacer {
  static Widget spaceHorizontal({double space}) => SizedBox(
        width: space,
      );

  static Widget spaceVertical({double space}) => SizedBox(
        height: space,
      );

  static get space10PixelVertical => SizedBox(
        height: 10.h,
      );

  static get space15PixelVertical => SizedBox(
        height: 15.h,
      );

  static get space15PixelHorizontal => SizedBox(
        width: 15.w,
      );

  static get space10PixelHorizontal => SizedBox(
        width: 10.w,
      );

  static get screenContentSpaceLeftRight =>
      EdgeInsets.only(left: 15.w, right: 15.w);
}

class LiShopInputDecoration {
  static InputDecoration linedDecoration(
      {String hintText, EdgeInsetsGeometry contentPadding}) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: LiShopColors.themeDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      hintText: hintText,
      hintStyle: LiShopTextStyle.lato400(fontSize: 12, color: LiShopColors.textLight),
      contentPadding: contentPadding == null
          ? EdgeInsets.only(left: 10.w, right: 10.w)
          : contentPadding,
    );
  }

  static InputDecoration planeDecoration(
      {String hintText, EdgeInsetsGeometry contentPadding}) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      contentPadding: contentPadding == null
          ? EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w)
          : contentPadding,
      hintText: hintText,
    );
  }
}

void showTwoButtonsSimpleDialog(
  BuildContext context,
  String title,
  String message, {
  VoidCallback btn1Pressed,
  VoidCallback btn2Pressed,
}) {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return WillPopScope(
        onWillPop: () {},
        child: AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: LiShopColors.textDark),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (btn2Pressed != null) {
                  btn2Pressed();
                }
              },
            ),
            new FlatButton(
              child: new Text(
                "Go to app settings",
                style: TextStyle(color: LiShopColors.textDark),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (btn1Pressed != null) {
                  btn1Pressed();
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
