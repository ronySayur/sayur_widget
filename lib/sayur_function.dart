// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:ui';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';
import 'dart:io';
import 'dart:math' show Random;

import 'package:no_screenshot/no_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'package:sayur_widget/sayur_core.dart';

//String to Map
Map<String, String> parseStringToMap(String input) {
  Map<String, String> result = {};
  List<String> keyValuePairs =
      input.replaceAll('{', '').replaceAll('}', '').split(', ');

  for (String pair in keyValuePairs) {
    List<String> keyValue = pair.split(': ');
    String key = keyValue[0].trim();
    String value = keyValue[1].trim();
    result[key] = value;
  }

  return result;
}

int charToInt(String char) {
  char = char.toLowerCase();
  return char.codeUnitAt(0) - 'a'.codeUnitAt(0) + 1;
}

int parseStringToInt(String text) {
  int result = 0;
  for (int i = 0; i < text.length; i++) {
    int intValue = charToInt(text[i]);
    result = result * 26 + intValue;
  }
  return result;
}

class Generator {
  static String randomKey(int length) {
    const c = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final r = Random();
    return String.fromCharCodes(List.generate(
      length,
      (index) => c.codeUnitAt(r.nextInt(c.length)),
    ));
  }

  static String randomNumber(int length) {
    const c = "0123456789";
    final r = Random();
    return String.fromCharCodes(List.generate(
      length,
      (index) => c.codeUnitAt(r.nextInt(c.length)),
    ));
  }
}

Future<void> YurScreenShot({required bool isOn}) async {
  NoScreenshot i = NoScreenshot.instance;
  if (isOn) {
    await i.screenshotOff();
  } else {
    await i.screenshotOn();
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

void dfp(dynamic parameter) {
  YurLog(name: "Default Function", "paramater : $parameter");
}

void df() {
  YurLog(name: "Default Function", "(){}");
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
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryRed,
      onPrimary: Colors.white,
      secondary: secondaryYellow,
      onSecondary: secondaryYellow,
      error: Colors.red,
      onError: Colors.red,
      surface: Colors.grey.shade200,
      onSurface: Colors.black,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: br16,
      ),
      elevation: 4,
      surfaceTintColor: Colors.white,
      shadowColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryRed,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.white,
    cardTheme: const CardTheme(
      elevation: 4,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: br8,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 4,
      iconTheme: IconThemeData(color: Colors.black),
      surfaceTintColor: Colors.white,
    ),
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

enum LoadingStatus { show, error, info, success, dismiss }

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

  YurLog(name: "YurToast", message);

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

void YurLoading({
  String? message,
  bool isDismisable = false,
  required LoadingStatus loadingStatus,
  InfoType toastType = InfoType.info,
  EasyLoadingIndicatorType indicatorType = EasyLoadingIndicatorType.chasingDots,
  Color? backgroundColor,
  int duration = 2,
}) {
  EasyLoading i = EasyLoading.instance;

  i
    ..displayDuration = Duration(seconds: duration)
    ..indicatorType = indicatorType
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..backgroundColor = backgroundColor ?? Colors.black.withOpacity(0.5)
    ..progressColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = isDismisable
    ..customAnimation
    ..loadingStyle = EasyLoadingStyle.custom;

  EasyLoading.addStatusCallback(
    (status) => YurLog(name: "EasyLoading", status.toString()),
  );

  switch (loadingStatus) {
    case LoadingStatus.show:
      EasyLoading.show(
        status: message ?? "Loading...",
        dismissOnTap: isDismisable,
      );
      break;
    case LoadingStatus.error:
      i.backgroundColor = backgroundColor ?? Colors.red;

      EasyLoading.showError(
        message ?? "Terjadi kesalahan...",
        dismissOnTap: isDismisable,
      );
      break;
    case LoadingStatus.info:
      i.backgroundColor = backgroundColor ?? Colors.blue;

      EasyLoading.showInfo(
        message ?? "Perhatian",
        dismissOnTap: isDismisable,
      );
      break;
    case LoadingStatus.success:
      i.backgroundColor = backgroundColor ?? Colors.green;

      EasyLoading.showSuccess(
        message ?? "Berhasil",
        dismissOnTap: isDismisable,
      );
      break;
    case LoadingStatus.dismiss:
      EasyLoading.dismiss();
      break;
  }
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
  required String title,
  required String message,
  required String buttonText,
  required Function() onConfirm,
  DialogType dialogType = DialogType.confirmation,
  String? message2,
  String? message3,
  Function()? onCancel,
  String? cancelText,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ],
                ),
                const YurDivider(),
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
                  if (message2 != null)
                    Column(
                      children: [
                        gap8,
                        YurText(
                          fontWeight: fontWeight,
                          text: message2,
                          textAlign: textAlign,
                          letterSpacing: 0.2,
                          maxLines: maxMessageLine,
                          color: primaryRed,
                        ),
                      ],
                    ),
                  if (message3 != null)
                    Column(
                      children: [
                        gap8,
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
                          text: cancelText ?? "Batal",
                          buttonStyle: BStyle.secondaryRed,
                          fontSize: 12,
                          onPressed: () =>
                              onCancel != null ? onCancel() : Get.back(),
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
                            YurLog(name: "YurcallDialog", title);
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

Future<dynamic> YurDialog1({
  required String title,
  required String subtitle,
  required String buttonConfirm,
  required Function() onPressedConfirm,
  double? sizeSubtitle,
  String? buttonCancel,
  Widget? icon,
  bool isDismisable = true,
  bool? isWithPostFrame,
  FontWeight? fontWeight,
}) {
  var showDialog2 = showDialog(
    context: Get.context,
    barrierDismissible: isDismisable,
    builder: (BuildContext context) {
      return AlertDialog(
        title: YurText(
          text: title,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        content: YurText(
          text: subtitle,
          textAlign: TextAlign.start,
          fontWeight: fontWeight ?? FontWeight.w300,
          fontSize: sizeSubtitle ?? 14,
          maxLines: 10,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (buttonCancel != null)
                Expanded(
                  child: YurButton(
                    buttonStyle: BStyle.primaryRed,
                    text: buttonCancel,
                    onPressed: Get.back,
                  ),
                ),
              gap12,
              Expanded(
                child: YurButton(
                  buttonStyle: BStyle.fullRed,
                  text: buttonConfirm,
                  onPressed: () {
                    onPressedConfirm();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
        icon: icon,
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 24,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: br16),
      );
    },
  );

  if (isWithPostFrame ?? false) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog2);
  }
  return showDialog2;
}

Future<dynamic> YurCustomDialog({
  String? title,
  required Widget content,
  required List<Widget> actions,
  Widget? icon,
  bool isDismisable = true,
}) {
  return showDialog(
    context: Get.context,
    barrierDismissible: isDismisable,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title == null
            ? null
            : YurText(
                text: title,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        content: IntrinsicHeight(child: content),
        actions: actions,
        icon: icon,
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 24,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: br16),
      );
    },
  );
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

  if (isDialogShow) return;

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
                          name: "MediSearch",
                          "MediDialogForm",
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
                          name: "MediSearch",
                          "MediDialogForm",
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

void YurLog(dynamic message, {String? name}) {
  DateTime now = DateTime.now();

  if (kDebugMode) {
    log(
      name: "${now.dateFormat("HH:mm:ss")} - ${name ?? "YurLog"}",
      message.toString(),
      time: now,
    );
  }
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

Future<String> selectDate({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  TimeOfDay? initialTime,
  bool withTimePick = false,
  bool Function(DateTime)? selectableDayPredicate,
}) async {
  DateTime newDateTime = DateTime.now();
  TimeOfDay? pickedTime;

  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
    selectableDayPredicate: (DateTime day) {
      if (selectableDayPredicate != null) {
        return selectableDayPredicate(day);
      }
      return true;
    },
  );

  if (pickedDate != null) {
    newDateTime = pickedDate;

    if (withTimePick) {
      pickedTime = await showTimePicker(
        context: Get.context,
        initialTime: initialTime ?? TimeOfDay.now(),
      );

      if (pickedTime != null) {
        newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        YurLog(name: "Picked Date", newDateTime.toString());
      }

      return newDateTime.toString();
    }

    return newDateTime.toString();
  } else {
    YurLog(name: "Picked Date else", initialDate.toString());

    return '';
  }
}

Position YurPosition({
  required double latitude,
  required double longitude,
  double? accuracy,
  double? altitude,
  double? heading,
  double? speed,
  double? speedAccuracy,
  double? altitudeAccuracy,
  double? headingAccuracy,
}) {
  Position position = Position(
    timestamp: DateTime.now(),
    latitude: latitude,
    longitude: longitude,
    accuracy: accuracy ?? 0.0,
    altitude: altitude ?? 0.0,
    heading: heading ?? 0.0,
    speed: speed ?? 0.0,
    speedAccuracy: speedAccuracy ?? 0.0,
    altitudeAccuracy: altitudeAccuracy ?? 0.0,
    headingAccuracy: headingAccuracy ?? 0.0,
  );
  return position;
}

class YurRing {
  static void play() {
    FlutterRingtonePlayer player = FlutterRingtonePlayer();
    player.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true,
      asAlarm: false,
    );
  }

  static void stop() {
    FlutterRingtonePlayer player = FlutterRingtonePlayer();
    player.stop();
  }
}

Future<void> YurDownload({
  required String url,
  required String fileName,
  String? saveDir,
}) async {
  await FlutterDownloader.enqueue(
    url: url,
    savedDir: saveDir ?? '/storage/emulated/0/Download',
    fileName: fileName,
    showNotification: true,
    openFileFromNotification: true,
    allowCellular: true,
  );
}
