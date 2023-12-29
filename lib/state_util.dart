import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayur_widget/function.dart';

BuildContext get globalContext => Get.context;

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get context {
    return navigatorKey.currentState?.context;
  }

  static to(Widget page) async {
    YurLog(message: "To : ${page.toString()}", name: "Get.to");
    return await navigatorKey.currentState!.push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static back({dynamic result}) {
    YurLog(message: "Back", name: "Get.back");
    if (Navigator.canPop(globalContext) == false) return;
    Navigator.pop(globalContext, result);
  }

  static replace(Widget page) async {
    YurLog(message: "Replace : ${page.toString()}", name: "Get.replace");
    return await navigatorKey.currentState!.pushReplacement(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static offAll(page) async {
    YurLog(message: "Off All : ${page.toString()}", name: "Get.offAll");
    return await navigatorKey.currentState!.pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }

  static popUntil() {
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
  static changeTheme(ThemeData theme) {
    mainTheme.value = theme;
  }

  static ThemeData get theme {
    return Theme.of(Get.context);
  }

  static ThemeData get lightTheme {
    return ThemeData.light();
  }
}
