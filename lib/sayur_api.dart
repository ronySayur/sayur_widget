// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

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
      bool result = await InternetConnectionChecker().hasConnection;

      if (!result) {
        YurLog(name: "Internet", "No Connection");

        YurToast(
            message: SayurTextConstants.noInternet, toastType: InfoType.error);

        return {"status": ""};
      }

      final requestDate = DateTime.now();
      final request = http.MultipartRequest('POST', Uri.parse(urlHttp));

      request.fields.addAll(dataMap.cast<String, String>());

      if (isGet) {
        final response = await http.get(
          Uri.parse(urlHttp),
          headers: {'content-type': 'application/json'},
        ).timeout(
          const Duration(seconds: 30),
          onTimeout: () => http.Response('', 500),
        );

        YurLog(name: urlHttp, request.fields.toString());

        return json.decode(utf8.decoder.convert(response.bodyBytes));
      } else if (isEncoded) {
        final url = Uri.parse(urlHttp);

        String encoded = jsonEncode(dataMap);

        final response = await http.post(url, body: encoded).timeout(
              const Duration(seconds: 30),
              onTimeout: () => http.Response('', 500),
            );

        YurLog(name: urlHttp, request.fields.toString());

        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        } else {
          return {"status": ""};
        }
      } else {
        final response = await request.send();
        final responseStream = await response.stream.bytesToString();

        final time = DateTime.now().difference(requestDate).inMilliseconds;
        final timeInSecond = time / 1000;

        YurLog(name: "$timeInSecond - $urlHttp", request.fields);

        bool cond = responseStream.isEmpty ||
            responseStream == "[]" ||
            responseStream.contains("No data");

        if (cond) {
          return {"status": ""};
        } else {
          return json.decode(responseStream);
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
