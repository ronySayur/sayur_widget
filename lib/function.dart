// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import 'package:day_night_time_picker/day_night_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:async';
import 'dart:io';
import 'dart:math' show Random;

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:sayur_widget/core.dart';

class FlagSecure {
  static Future<void> futuerFlag({
    required bool isAddFlagSecure,
  }) async {
    if (isAddFlagSecure) {
      await NoScreenshot.instance.screenshotOff();
    } else {
      await NoScreenshot.instance.screenshotOn();
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

extension DateFormatExtension on DateTime {
  String dateFormat(String format) {
    return DateFormat(format).format(this);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

void dfp(dynamic parameter) {
  YurLog(name: "dfp", message: parameter);
}

void df() {
  YurLog(name: "df", message: "(){}");
}

String YurRandomKey(int length) {
  const chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  final random = Random();
  return String.fromCharCodes(List.generate(
      length, (index) => chars.codeUnitAt(random.nextInt(chars.length))));
}

String YurRandomNumber(int length) {
  const chars = "0123456789";
  final random = Random();
  return String.fromCharCodes(List.generate(
      length, (index) => chars.codeUnitAt(random.nextInt(chars.length))));
}

Position YurPosition(String lng, String lat) {
  return Position(
    longitude: double.parse(lng),
    latitude: double.parse(lat),
    timestamp: DateTime.now(),
    altitudeAccuracy: 0,
    headingAccuracy: 0,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

Future<String> YurDownloadFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

ThemeData YurTheme() {
  return ThemeData(
    primarySwatch: primaryRed,
    useMaterial3: true,
    fontFamily: 'Poppins',
    visualDensity: VisualDensity.adaptivePlatformDensity,

    //  ==================================> ColorScheme <==================================
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryRed,
      onPrimary: Colors.white,
      secondary: secondaryYellow,
      onSecondary: secondaryYellow,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.grey.shade200,
      onSurface: Colors.black,
    ),

    //  ==================================> Dialog <==================================
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: br16,
      ),
      elevation: 4,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.white,

    //  ==================================> FAB <==================================
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
    ),

    //  ==================================> Card <==================================
    cardColor: Colors.white,
    cardTheme: const CardTheme(
      elevation: 4,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: br8,
      ),
    ),

    //  ==================================> AppBar <==================================
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.black),
      surfaceTintColor: Colors.white,
    ),

    //  ==================================> BottomBar <==================================
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 4,
      selectedItemColor: primaryRed,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      selectedIconTheme: IconThemeData(color: primaryRed),
      selectedLabelStyle: TextStyle(color: primaryRed),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
      elevation: 4,
      surfaceTintColor: Colors.white,
      shape: CircularNotchedRectangle(),
    ),
  );
}

void YurToast({
  required String message,
  InfoType toastType = InfoType.info,
  Toast duration = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.CENTER,
  int timeInSecForIosWeb = 1,
  Color? backgroundColor,
  Color? textColor = Colors.white,
  double fontSize = 14.0,
}) {
  if (backgroundColor == null) {
    switch (toastType) {
      case InfoType.info:
        backgroundColor = primaryRed;
        break;
      case InfoType.warning:
        backgroundColor = secondaryYellow;
        break;
      case InfoType.error:
        backgroundColor = primaryRed;
        break;
      case InfoType.success:
        backgroundColor = tertiaryGreen;
        break;
    }
  }

  Fluttertoast.showToast(
    msg: message,
    toastLength: duration,
    gravity: gravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}

void YurSnackBar({
  required String message,
  InfoType snackBarType = InfoType.success,
  double duration = 3,
  double fontSize = 16.0,
  int maxLines = 2,
  TextAlign textAlign = TextAlign.start,
}) {
  var scaffoldMessenger = ScaffoldMessenger.of(Get.context);

  Color backgroundColor = Colors.green;
  Color textColor = Colors.white;

  switch (snackBarType) {
    case InfoType.info:
      backgroundColor = Colors.blue;
      textColor = Colors.white;
      break;
    case InfoType.success:
      backgroundColor = Colors.green;
      textColor = Colors.white;
      break;
    case InfoType.error:
      backgroundColor = Colors.red;
      textColor = Colors.white;
      break;
    case InfoType.warning:
      backgroundColor = Colors.orange;
      textColor = Colors.white;
      break;
  }

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: YurText(
        text: message,
        color: textColor,
        fontWeight: FontWeight.w500,
        maxLines: maxLines,
        textAlign: textAlign,
        fontSize: fontSize,
      ),
      backgroundColor: backgroundColor,
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: scaffoldMessenger,
          animationBehavior: AnimationBehavior.preserve,
          duration: const Duration(milliseconds: 500),
        ),
        curve: Curves.easeInOut,
      ),
      duration: Duration(seconds: duration.toInt()),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(borderRadius: br4),
      action: SnackBarAction(
        label: "Tutup",
        textColor: textColor,
        onPressed: () => scaffoldMessenger.hideCurrentSnackBar(),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      closeIconColor: textColor,
      padding: e12,
      dismissDirection: DismissDirection.horizontal,
      showCloseIcon: false,
    ),
  );
}

YurAlertDialog({
  required BuildContext context,
  DialogType dialogType = DialogType.confirmation,
  required String title,
  required String message,
  String? message2,
  String? message3,
  required String buttonText,
  required Function() onConfirm,
  Function()? onCancel,
  Color barrierColor = Colors.black54,
  double elevasi = 24,
  textAlign = TextAlign.justify,
  int maxMessageLine = 4,
  FontWeight fontWeight = FontWeight.w400,
  bool isDismissable = true,
}) async {
  return WidgetsBinding.instance.addPostFrameCallback((_) async {
    await showDialog(
      context: context,
      barrierDismissible: isDismissable
          ? dialogType == DialogType.confirmation
              ? true
              : false
          : false,
      barrierColor: barrierColor.withOpacity(0.5),
      useSafeArea: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return PopScope(
          canPop: (dialogType == DialogType.confirmation),
          onPopInvoked: (didPop) {
            if (!didPop) {
              Future.delayed(const Duration(microseconds: 500), () {
                onConfirm();
              });
            }
          },
          child: AlertDialog(
            alignment: Alignment.center,
            elevation: elevasi,
            scrollable: true,
            shadowColor: Colors.black,
            actionsPadding: e12,
            actionsAlignment: MainAxisAlignment.spaceAround,
            actionsOverflowAlignment: OverflowBarAlignment.center,
            actionsOverflowButtonSpacing: 16,
            buttonPadding: eH16,
            insetPadding: e16,
            titlePadding: e16,
            actionsOverflowDirection: VerticalDirection.down,
            surfaceTintColor: Colors.grey.shade100,
            backgroundColor: Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticLabel: title,
            title: Column(
              children: [
                YurText(
                  fontSize: 20,
                  text: title,
                  color: primaryRed,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
                if (dialogType == DialogType.confirmation)
                  IconButton(
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel();
                      } else {
                        Get.back();
                      }
                    },
                    icon: const YurIcon(
                      icon: Icons.cancel_outlined,
                      color: primaryRed,
                    ),
                  )
                else
                  gap0,
                const YurDivider()
              ],
            ),
            content: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  YurText(
                    fontWeight: fontWeight,
                    text: message,
                    textAlign: textAlign,
                    letterSpacing: 0.2,
                    maxLines: maxMessageLine,
                    color: Colors.black87,
                  ),
                  if (message2 != null) gap8,
                  if (message2 != null)
                    YurText(
                      fontWeight: fontWeight,
                      text: message2,
                      textAlign: textAlign,
                      letterSpacing: 0.2,
                      maxLines: maxMessageLine,
                      color: primaryRed,
                    ),
                  if (message3 != null) gap8,
                  if (message3 != null)
                    YurText(
                      fontWeight: fontWeight,
                      text: message3,
                      textAlign: textAlign,
                      letterSpacing: 0.2,
                      maxLines: maxMessageLine,
                      color: primaryRed,
                    ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(borderRadius: br16),
            actions: [
              Column(
                children: [
                  const YurDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (dialogType == DialogType.confirmation)
                        Expanded(
                            child: YurButton(
                          text: "Batal",
                          buttonStyle: BStyle.secondary,
                          fontSize: 12,
                          onPressed: () {
                            onCancel != null ? onCancel() : Get.back();
                          },
                        )),
                      if (dialogType == DialogType.confirmation) gap8,
                      Expanded(
                          child: YurButton(
                        text: buttonText,
                        buttonStyle: BStyle.primaryRed,
                        fontSize: 12,
                        onPressed: () {
                          Future.delayed(const Duration(microseconds: 500), () {
                            onConfirm();
                            Get.back();
                            YurLog(name: "YurcallDialog", message: title);
                          });
                        },
                      )),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  });
}

YurDialog({
  required BuildContext context,
  required String message,
  String? message2,
  bool isDialogShow = false,
  bool isDismissable = false,
  bool isSuccess = true,
  double fontSize = 16,
  Color fontColor = primaryRed,
  FontWeight fontWeight = FontWeight.w500,
  Function()? onConfirm,
}) async {
  if (isDialogShow) {
    return;
  }

  isDialogShow = true;
  return WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      useSafeArea: true,
      useRootNavigator: true,
      
      builder: (BuildContext context) {
        var img = isSuccess ? 'accept_order_success' : 'failed';

        return PopScope(
          canPop: isDismissable,
          onPopInvoked: (didPop) {
            if (didPop) {
              isDialogShow = true;
            } else {
              Get.back();
              onConfirm!();
            }
          },
          child: Dialog(
            elevation: 3,

            insetPadding: e16,
            shape: const RoundedRectangleBorder(borderRadius: br16),
            backgroundColor: Colors.white.withOpacity(0.99),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: IntrinsicHeight(
              child: Padding(
                padding: e12,
                child: Column(
                  children: [
                    YurImageAsset(
                      imageUrl: 'assets/images/assignment/$img.png',
                      height: 200,
                    ),
                    gapH20,
                    YurText(
                      fontSize: fontSize,
                      text: message,
                      textAlign: TextAlign.center,
                      color: fontColor,
                      fontWeight: fontWeight,
                      maxLines: 10,
                    ),
                    if (message2 != null)
                      Column(
                        children: [
                          gap12,
                          YurText(
                            fontSize: fontSize,
                            text: message2,
                            textAlign: TextAlign.center,
                            color: primaryRed,
                            fontWeight: fontWeight,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    if (onConfirm != null)
                      Column(
                        children: [
                          gapH20,
                          YurButton(
                              buttonStyle: BStyle.primaryRed,
                              text: "OK",
                              onPressed: () {
                                onConfirm();
                                Get.back();
                                YurLog(
                                  name: "YurcallDialog",
                                  message: "YurDialog",
                                );
                              })
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  });
}

YurSearch({
  required BuildContext context,
  required Function(TextEditingController textController) onConfirm,
  Function()? onCancel,
  bool isDialogShow = false,
  bool isDismissable = true,
  bool isSuccess = true,
  required String labelForm,
  required TextEditingController textController,
}) async {
  textController.text = "";

  if (isDialogShow) {
    return;
  }

  isDialogShow = true;

  return showDialog(
    context: context,
    barrierColor: Colors.black54,
    useSafeArea: true,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: PopScope(
          canPop: isDialogShow && isDismissable,
          onPopInvoked: (didPop) {
            if (didPop) {
              onConfirm(textController);
            }
          },
          child: Dialog(
            elevation: 3,
            insetPadding: e16,
            shape: const RoundedRectangleBorder(borderRadius: br16),
            backgroundColor: Colors.white.withOpacity(0.99),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Padding(
              padding: e12,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: YurForm(
                      label: labelForm,
                      focusNode: FocusNode(),
                      controller: textController,
                      onComplete: () {
                        onConfirm(textController);
                        Get.back();
                        YurLog(
                          name: "YurcallDialog",
                          message: "YurDialogForm",
                        );
                      },
                    ),
                  ),
                  gapW8,
                  Expanded(
                    flex: 1,
                    child: YurButton(
                      text: "Cari",
                      buttonStyle: BStyle.primaryRed,
                      fontSize: 12,
                      onPressed: () {
                        onConfirm(textController);
                        Get.back();

                        YurLog(
                          name: "YurcallDialog",
                          message: "YurDialogForm",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void YurLog({
  required String name,
  required String message,
}) {
  DateTime logNow = DateTime.now();
  LogType logType = kDebugMode ? LogType.log : LogType.debugPrint;
  switch (logType) {
    case LogType.log:
      DateTime now = DateTime.now();
      log(
        name: "${logNow.dateFormat("HH:mm:ss")} - $name",
        message,
        time: now,
      );
      break;
    case LogType.debugPrint:
      debugPrint("${logNow.dateFormat("HH:mm:ss")} - $name");
      debugPrint(message);
      break;
  }
}

Future<void> YurCrash({
  required String name,
  required dynamic e,
  StackTrace s = StackTrace.empty,
}) async {
  FirebaseCrashlytics i = FirebaseCrashlytics.instance;
  i.setCrashlyticsCollectionEnabled(true);
  i.log("${DateTime.now().dateFormat("HH:mm:ss")} - $name");
  String error = "[$name] - ${e.toString()}";
  await i.recordError(error, s);
}

void YurShowPicker({
  required BuildContext context,
  required TextEditingController controller,
  double? minHour,
  double? minMinute,
}) {
  Navigator.of(context).push(
    showPicker(
      context: context,
      value: Time(
          hour: controller.text.isEmpty
              ? 0
              : int.parse(controller.text.split(":")[0]),
          minute: controller.text.isEmpty
              ? 0
              : int.parse(controller.text.split(":")[1])),
      onChange: (value) {
        String formattedHour = value.hour.toString().padLeft(2, '0');
        String formattedMinute = value.minute.toString().padLeft(2, '0');

        controller.text = "$formattedHour:$formattedMinute";
      },
      is24HrFormat: true,
      iosStylePicker: true,
      blurredBackground: true,
      elevation: 5,
      minHour: minHour ?? 00,
      minMinute: minMinute ?? 00,
      okText: "Pilih",
      cancelText: "Batal",
      okStyle: const TextStyle(
        color: primaryRed,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      cancelStyle: const TextStyle(
        color: primaryRed,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      themeData: ThemeData(primaryColor: primaryRed),
    ),
  );
}
