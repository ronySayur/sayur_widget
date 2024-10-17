import 'dart:io';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sayur_widget/sayur_core.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
class YurPermissionRequest {
  static bool isShowDialog = true;

  static Future<bool> isLocationGranted() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      bool denied = permission == LocationPermission.denied,
          deniedForever = permission == LocationPermission.deniedForever;

      String message =
          "To provide the best possible service, we recommend enabling location services. With location access, we can offer more accurate and maximize services based on your current location. You can enable or disable this feature anytime in your settings.";

      if (denied) {
        permission = await Geolocator.requestPermission();

        YurAlertDialog(
          context: Get.context,
          title: "Enable Location Access",
          message: message,
          buttonText: "Enable Location",
          cancelText: "Maybe Later",
          onConfirm: Geolocator.requestPermission,
        );

        return false;
      }

      if (deniedForever && isShowDialog) {
        isShowDialog = false;
        YurLoading(loadingStatus: LoadingStatus.dismiss);

        YurAlertDialog(
          context: Get.context,
          title: "Enable Location Access",
          message: message,
          buttonText: "Enable Location",
          cancelText: "Maybe Later",
          onCancel: () {
            isShowDialog = true;
            Get.back();
            return false;
          },
          onConfirm: () async {
            if (Platform.isAndroid) {
              await Geolocator.requestPermission();
            } else if (Platform.isIOS) {
              await Geolocator.openLocationSettings();
            }

            isShowDialog = true;
            Get.back();
          },
        );
      }

      return true;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }

  static Future<Position> getPosition({
    Position? lastPosition,
  }) async {
    Position position = lastPosition ?? YurPosition(latitude: 0, longitude: 0);
    try {
      bool isGranted = await isLocationGranted();
      if (isGranted) {
        return position = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 10,
          ),
        );
      } else {
        return position;
      }
    } catch (e) {
      YurLog(e);
      return position;
    }
  }

  static Future<bool> isNotification() async {
    try {
      final bool notification;

      if (Platform.isAndroid) {
        notification = await YurNotification.flutterNotif
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.areNotificationsEnabled() ??
            false;
      } else {
        notification = await YurNotification.flutterNotif
                .resolvePlatformSpecificImplementation<
                    IOSFlutterLocalNotificationsPlugin>()
                ?.requestPermissions(alert: true, badge: true, sound: true) ??
            false;
      }

      return notification;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }

  static Future<bool> isDeveloperOn() async {
    try {
      bool isDeveloperOn = false;

      if (Platform.isAndroid) {
        isDeveloperOn = await FlutterJailbreakDetection.developerMode;
      }

      return isDeveloperOn;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }

  static Future<bool> isMocked() async {
    try {
      Position position = await getPosition();
      bool isMocked = false;

      if (position.isMocked) isMocked = true;
      if (Platform.isIOS) isMocked = false;

      return isMocked;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }

  static Future<bool> isCamera() async {
    try {
      PermissionStatus status = await Permission.camera.status;

      YurLog(status.toString());

      if (status.isDenied) {
        status = await Permission.camera.request();
        return false;
      }

      if (status.isPermanentlyDenied) {
        if (isShowDialog) {
          isShowDialog = false;
          YurLoading(loadingStatus: LoadingStatus.dismiss);
          YurAlertDialog(
            context: Get.context,
            title: "Izinkan Kamera",
            message: "Aplikasi ini membutuhkan izin kamera anda",
            buttonText: "Izinkan",
            onCancel: () {
              isShowDialog = true;
              Get.back();
              return false;
            },
            onConfirm: () {
              AppSettings.openAppSettings(type: AppSettingsType.settings);
              isShowDialog = true;
              Get.back();
            },
          );
        }
      }

      return true;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }
}
