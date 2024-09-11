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
    Map<String, String> headers = const {'content-type': 'application/json'},
  }) async {
    String body = "";
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) return {"status": ""};

      YurLog(name: urlHttp, dataMap);
      final url = Uri.parse(urlHttp);
      const timeout = 30;
      onTimeout() => http.Response('', 500);

      if (isGet) {
        final response = await http
            .get(url, headers: headers)
            .timeout(timeout.seconds, onTimeout: onTimeout);

        var decoded = json.decode(utf8.decoder.convert(response.bodyBytes));
        body = decoded.toString();
        return decoded;
      }

      if (isEncoded) {
        var responEncode = await http
            .post(url, headers: headers, body: jsonEncode(dataMap))
            .timeout(timeout.seconds, onTimeout: onTimeout);

        var decoded = await json.decode(responEncode.body);
        body = decoded.toString();
        return decoded;
      }

      final serverRequest = http.MultipartRequest('POST', url);

      serverRequest.fields
        ..addAll(dataMap.cast<String, String>())
        ..addAll(headers);

      final response = await serverRequest
          .send()
          .timeout(timeout.seconds, onTimeout: serverRequest.send);

      final data = await response.stream.bytesToString();
      body = data;

      bool empty = data.isEmpty || data == "[]" || data.contains("No data");
      if (empty) return {"status": ""};

      return await json.decode(data);
    } catch (e) {
      YurLog(name: urlHttp, "Error: $e | $body");
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

      if (!result) return {"status": ""};

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
