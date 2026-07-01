// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:math';

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
    Map<String, String> emptyStatus = {
      "status": "",
      "message": "",
    };

    try {
      bool result = await InternetConnectionChecker.instance.hasConnection;
      if (!result) return emptyStatus;

      YurLog(name: "📤 REQUEST - $urlHttp", dataMap);
      final url = Uri.parse(urlHttp);
      const timeout = 30;
      onTimeout() => http.Response('', 500);

      if (isGet) {
        final response = await http
            .get(url, headers: headers)
            .timeout(timeout.seconds, onTimeout: onTimeout);

        body = response.body;
        var decoded = json.decode(utf8.decoder.convert(response.bodyBytes));
        YurLog(name: "📥 RESPONSE - $urlHttp", decoded);
        return decoded;
      }

      if (isEncoded) {
        var responEncode = await http
            .post(url, headers: headers, body: jsonEncode(dataMap))
            .timeout(timeout.seconds, onTimeout: onTimeout);

        body = responEncode.body;
        var decoded = await json.decode(body);
        YurLog(name: "📥 RESPONSE - $urlHttp", decoded);
        return decoded;
      }

      final serverRequest = http.MultipartRequest('POST', url);

      serverRequest.fields
        ..addAll(dataMap.cast<String, String>())
        ..addAll(headers);

      final response = await serverRequest
          .send()
          .timeout(timeout.seconds, onTimeout: serverRequest.send);

      body = await response.stream.bytesToString();

      bool empty = body.isEmpty || body == "[]" || body.contains("No data");
      if (empty) {
        YurLog(name: "📥 RESPONSE - $urlHttp", "Empty response");
        return emptyStatus;
      }

      var decoded = await json.decode(body);
      YurLog(name: "📥 RESPONSE - $urlHttp", decoded);
      return decoded;
    } catch (e) {
      YurLog(name: "❌ ERROR - $urlHttp", "Error: $e | $body");
      emptyStatus["message"] = e.toString().trim();
      return emptyStatus;
    }
  }

  static Future<Map<String, dynamic>> IP() async {
    try {
      bool result = await InternetConnectionChecker.instance.hasConnection;
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
    bool result = await InternetConnectionChecker.instance.hasConnection;
    if (!result) return {"status": ""};

    final userAgents = [
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)',
      'Mozilla/5.0 (X11; Linux x86_64)',
      'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)',
      'Mozilla/5.0 (Android 14; Mobile; rv:127.0)',
    ];

    final referrers = [
      'https://google.com',
      'https://duckduckgo.com',
      'https://maps.app',
    ];

    final timeSeed = DateTime.now().millisecondsSinceEpoch;
    final random = Random(timeSeed);

    final randomUserAgent = userAgents[random.nextInt(userAgents.length)];
    final randomReferrer = referrers[random.nextInt(referrers.length)];

    final url =
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon&accept-language=id';

    final headers = {
      'User-Agent': '$randomUserAgent (${timeSeed % 10000})',
      'Accept-Language': 'id',
      'Content-Type': 'application/json',
      'Referer': randomReferrer,
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers).timeout(
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
