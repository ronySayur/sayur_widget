import 'dart:io';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:sayur_widget/sayur_core.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
class PermissionRequest {
  static bool isShow = true;
  @pragma('vm:entry-point')
  static Future<bool> getLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();

      YurLog(permission.toString());

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        return false;
      }
      
      if (permission == LocationPermission.deniedForever) {
        if (isShow) {
          isShow = false;
          YurLoading(loadingStatus: LoadingStatus.dismiss);
          YurAlertDialog(
            context: Get.context,
            title: "Izinkan Lokasi",
            message: "Medi-Call membutuhkan izin lokasi anda",
            buttonText: "Izinkan",
            onCancel: () {
              isShow = true;
              Get.back();
              return false;
            },
            onConfirm: () {
              AppSettings.openAppSettings(type: AppSettingsType.location);
              isShow = true;
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
      } else {
        isDeveloperOn = await FlutterJailbreakDetection.jailbroken;
      }

      return isDeveloperOn;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }

  static Future<bool> isMocked() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      bool isMocked = false;
      bool geolocator = position.isMocked;
      if (geolocator) {
        isMocked = true;
      }

      return isMocked;
    } catch (e) {
      YurLog(e);
      return false;
    }
  }
}
