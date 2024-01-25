import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayur_widget/sayur_function.dart';

BuildContext get globalContext => Get.context;

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get context {
    return navigatorKey.currentState?.context;
  }

  static void back({dynamic result}) {
    YurLog(message: "Back", name: "Get.back");
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    }
  }

  static Future<void> to(Widget page) async {
    YurLog(message: "To : ${page.toString()}", name: "Get.to");

    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<void> replace(Widget page) async {
    YurLog(message: "Replace : ${page.toString()}", name: "Get.replace");
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<void> offAll(Widget page) async {
    YurLog(message: "Off All : ${page.toString()}", name: "Get.offAll");
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static void popUntil() {
    YurLog(message: "Pop Until", name: "Get.popUntil");
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static double get width {
    return MediaQuery.of(context).size.width;
  }

  static double get height {
    return MediaQuery.of(context).size.height;
  }

  static ValueNotifier<ThemeData> mainTheme =
      ValueNotifier<ThemeData>(ThemeData());

  static void changeTheme(ThemeData theme) {
    mainTheme.value = theme;
  }

  static ThemeData get theme {
    return Theme.of(context);
  }

  static ThemeData get lightTheme {
    return ThemeData.light();
  }
}
