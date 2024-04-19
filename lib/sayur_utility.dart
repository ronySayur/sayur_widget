import 'package:flutter/cupertino.dart';
import 'package:sayur_widget/sayur_function.dart';

BuildContext get globalContext => Get.context;

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get context {
    return navigatorKey.currentState?.context;
  }

  static void back({dynamic result}) {
    YurLog("Back", name: "Get.back");
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
    }
  }

  static Future<dynamic> to(
    Widget page, {
    BuildContext? localContext,
  }) async {
    YurLog("To : ${page.toString()}", name: "Get.to");

    await Navigator.push(
      localContext ?? context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<dynamic> replace(
    Widget page, {
    BuildContext? localContext,
  }) async {
    YurLog("Replace : ${page.toString()}", name: "Get.replace");
    await Navigator.pushReplacement(
      localContext ?? context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }

  static Future<dynamic> offAll(
    Widget page, {
    BuildContext? localContext,
  }) async {
    YurLog("Off All : ${page.toString()}", name: "Get.offAll");
    await Navigator.pushAndRemoveUntil(
      localContext ?? context,
      CupertinoPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static Future<dynamic> firstRoute() async {
    YurLog("First Route", name: "Get.firstRoute");
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  static double get width {
    return MediaQuery.of(context).size.width;
  }

  static double get height {
    return MediaQuery.of(context).size.height;
  }
}
