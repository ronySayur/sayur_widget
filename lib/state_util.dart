import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayur_widget/function.dart';

BuildContext get globalContext => Get.context;

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? _context;

  static BuildContext get context {
    if (_context == null) {
      throw Exception("Get context not initialized. Call Get.initContext first.");
    }
    return _context!;
  }

  static void initContext(BuildContext initialContext) {
    _context = initialContext;
  }

  static void back({dynamic result}) {
    YurLog(message: "Back", name: "Get.back");
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    }
  }

   static Future<void> to(Widget page) async {
    YurLog(message: "To : ${page.toString()}", name: "Get.to");
    await navigatorKey.currentState!.push(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<void> replace(Widget page) async {
    YurLog(message: "Replace : ${page.toString()}", name: "Get.replace");
    await navigatorKey.currentState!.pushReplacement(
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<void> offAll(Widget page) async {
    YurLog(message: "Off All : ${page.toString()}", name: "Get.offAll");
    await navigatorKey.currentState!.pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
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
