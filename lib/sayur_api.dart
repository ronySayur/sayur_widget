// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:sayur_widget/sayur_core.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class YurApi {
  static Future<Map<String, dynamic>> Respon({
    required String urlHttp,
    required Map<String, dynamic> dataMap,
    bool isEncoded = false,
    bool isGet = false,
    Map<String, String> headers = const {},
  }) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) {
        if (!Get.isDialogShown) {
          YurDialog1(
            title: "Tidak Ada Koneksi Internet",
            subtitle: "Silahkan cek koneksi internet Anda",
            buttonConfirm: "OK",
            onPressedConfirm: () {
              Get.back();
              AppSettings.openAppSettings(type: AppSettingsType.wireless);
            },
          );
        }
        return {"status": ""};
      }

      final url = Uri.parse(urlHttp);
      const timeout = 30;
      onTimeout() => http.Response('', 500);
      YurLog(name: urlHttp, dataMap);

      if (isGet) {
        final response = await http.get(url, headers: {
          'content-type': 'application/json',
        }).timeout(timeout.seconds, onTimeout: onTimeout);

        return json.decode(utf8.decoder.convert(response.bodyBytes));
      }

      if (isEncoded) {
        var responEncode = await http
            .post(url, headers: headers, body: jsonEncode(dataMap))
            .timeout(timeout.seconds, onTimeout: onTimeout);
        var decoded = await json.decode(responEncode.body);
        return decoded;
      }

      final request = http.MultipartRequest('POST', url);
      request.fields.addAll(dataMap.cast<String, String>());
      request.headers.addAll(headers);

      final response = await request
          .send()
          .timeout(timeout.seconds, onTimeout: request.send);

      final responseStream = await response.stream.bytesToString();

      bool empty = responseStream.isEmpty ||
          responseStream == "[]" ||
          responseStream.contains("No data");

      if (empty) return {"status": ""};

      return await json.decode(responseStream);
    } catch (e) {
      return {"status": ""};
    }
  }

  static Future<Map<String, dynamic>> IP() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) return {"status": ""};

      final response = await http
          .get(Uri.parse('https://ipinfo.io/json'))
          .timeout(30.seconds, onTimeout: () => http.Response('', 500));

      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return {"status": ""};
      }
    } catch (e) {
      return {"status": ""};
    }
  }

  static Future<Map<String, dynamic>> Nominatim({
    required String lat,
    required String lon,
  }) async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;

      if (!result) {
        return {"status": ""};
      }

      String url =
          'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon&accept-language=id';

      final response = await http.get(Uri.parse(url)).timeout(
            30.seconds,
            onTimeout: () => http.Response('', 500),
          );

      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return {"status": ""};
      }
    } catch (e) {
      return {"status": ""};
    }
  }
}
