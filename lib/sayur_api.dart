// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:isolate';

import 'package:sayur_widget/sayur_core.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class YurApi {
  static Future<Map<String, dynamic>> Respon({
    required String urlHttp,
    required Map<String, dynamic> dataMap,
    bool isEncoded = false,
    bool isGet = false,
  }) async {
    try {
      const timeout = 30;
      onTimeout() => http.Response('', 500);

      bool result = await InternetConnectionChecker().hasConnection;
      
      if (!result) {
        YurToast(
          message: SayurTextConstants.noInternet,
          toastType: InfoType.error,
        );
        return {"status": ""};
      }

      final url = Uri.parse(urlHttp);
      YurLog(name: urlHttp, dataMap);

      if (isGet) {
        var headers = {'content-type': 'application/json'};

        final response = await http
            .get(url, headers: headers)
            .timeout(const Duration(seconds: timeout), onTimeout: onTimeout);

        return json.decode(utf8.decoder.convert(response.bodyBytes));
      } else if (isEncoded) {
        String body = jsonEncode(dataMap);

        var responEncode = await http
            .post(url, body: body)
            .timeout(const Duration(seconds: timeout), onTimeout: onTimeout);

        var decoded = await Isolate.run(() => json.decode(responEncode.body));

        return decoded;
      } else {
        final request = http.MultipartRequest('POST', url);
        request.fields.addAll(dataMap.cast<String, String>());

        final response = await request.send().timeout(
              const Duration(seconds: timeout),
              onTimeout: () => request.send(),
            );

        final responseStream = await response.stream.bytesToString();

        bool cond = responseStream.isEmpty ||
            responseStream == "[]" ||
            responseStream.contains("No data");

        if (cond) {
          return {"status": ""};
        } else {
          return await Isolate.run(() => json.decode(responseStream));
        }
      }
    } catch (e) {
      return {"status": ""};
    }
  }

  static Future<Map<String, dynamic>> IP() async {
    try {
      bool result = await InternetConnectionChecker().hasConnection;

      if (!result) {
        return {"status": ""};
      }

      final response = await http
          .get(
            Uri.parse('https://ipinfo.io/json'),
          )
          .timeout(
            const Duration(seconds: 30),
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
            const Duration(seconds: 30),
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
