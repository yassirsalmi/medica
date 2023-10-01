import 'package:flutter/material.dart';

class Config {
  static MediaQueryData? mediaQueryData;
  static double? screenwidth;
  static double? screenHeight;

  //width and height initialisation
  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenwidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
  }

  static get widthSize {
    return screenwidth;
  }

  static get heightSize {
    return screenHeight;
  }

  //define the spacing
  static const smallSpace = SizedBox(
    height: 25.0,
  );
  static final midiumSpace = SizedBox(
    height: screenHeight! * 0.05,
  );
  static final bigSpace = SizedBox(
    height: screenHeight! * 0.08,
  );

  //textFormField border
  static const outlinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.greenAccent),
  );

  static const errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.red),
  );

  static const primaryColor = Colors.greenAccent;
}
