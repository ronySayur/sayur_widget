import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sayur_widget/sayur_core.dart';
import 'package:url_launcher/url_launcher.dart';

BuildContext get globalContext => Get.context;

enum UrlScheme { http, telp }

class Get {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static get context => navigatorKey.currentState?.context;

  static double get width => MediaQuery.of(context).size.width;
  static double get height => MediaQuery.of(context).size.height;

  static void close() {
    YurLog("Close App", name: "Get.closeApp");
    SystemNavigator.pop(animated: true);
  }

  static void back({dynamic result}) {
    YurLog("Back", name: "Get.back");
    EasyLoading.dismiss();
    if (Navigator.canPop(context)) Navigator.pop(context, result);
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

  static Future<void> launch({
    required String url,
    required UrlScheme urlScheme,
  }) async {
    switch (urlScheme) {
      case UrlScheme.http:
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        break;
      case UrlScheme.telp:
        await launchUrl(Uri(scheme: 'tel', path: url));
        break;
    }
  }
}
