// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'dart:math';

import 'package:sayur_widget/sayur_core.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

class YurApi {
  static Future<Map<String, dynamic>> Respon({
    required String urlHttp,
    required Map<String, dynamic> dataMap,
    bool isEncoded = false,
    bool isGet = false,
    Map<String, String> headers = const {'content-type': 'application/json'},
  }) async {
    String body = "";
    int statusCode = 200;
    Map<String, String> emptyStatus = {
      "status": "",
      "message": "",
    };
    Map<String, String> responseHeaders = {};
    final stopwatch = Stopwatch()..start();
    String httpMethod = isGet ? "GET" : "POST";

    try {
      bool result = await InternetConnectionChecker.instance.hasConnection;
      if (!result) return emptyStatus;

      final url = Uri.parse(urlHttp);
      const timeout = 30;
      onTimeout() => http.Response('', 500);

      http.Response? res;
      String? streamBody;

      if (isGet) {
        res = await http.get(url, headers: headers).timeout(timeout.seconds, onTimeout: onTimeout);
      } else if (isEncoded) {
        res = await http.post(url, headers: headers, body: jsonEncode(dataMap)).timeout(timeout.seconds, onTimeout: onTimeout);
      } else {
        final serverRequest = http.MultipartRequest('POST', url);
        serverRequest.fields
          ..addAll(dataMap.cast<String, String>())
          ..addAll(headers);
        final response = await serverRequest.send().timeout(timeout.seconds, onTimeout: serverRequest.send);
        streamBody = await response.stream.bytesToString();
        res = http.Response(streamBody, response.statusCode, headers: response.headers);
      }
      
      stopwatch.stop();
      final responseTime = stopwatch.elapsedMilliseconds;
      body = res.body;
      statusCode = res.statusCode;
      responseHeaders = res.headers;

      String generateDetailedLog(String errorType, String errorMessage, [dynamic stacktrace]) {
        String reqBodyStr = isEncoded ? jsonEncode(dataMap) : dataMap.toString();
        String resBodyStr = body.length > 1000 ? body.substring(0, 1000) + '... (truncated)' : body;
        return '''
Timestamp: ${DateTime.now().toIso8601String()}
API Endpoint: $urlHttp
HTTP Method: $httpMethod
Status Code: $statusCode
Request Header: $headers
Request Body: $reqBodyStr
Response Header: $responseHeaders
Response Body: $resBodyStr
Response Time: ${responseTime}ms
Error Type: $errorType
Error Message: $errorMessage
Stacktrace: ${stacktrace ?? 'N/A'}
''';
      }

      if (statusCode < 200 || statusCode >= 300) {
        YurLog(
          generateDetailedLog("HTTP Error", "Terjadi kesalahan HTTP (Status Code $statusCode)"),
          name: "ERROR",
          level: Level.error,
        );
        emptyStatus["message"] = "Error $statusCode: Terjadi kesalahan pada server.";
        return emptyStatus;
      }

      bool empty = body.isEmpty || body == "[]" || body.contains("No data");
      if (empty) {
        YurLog(
          generateDetailedLog("Warning", "Empty response body"),
          name: "WARNING",
          level: Level.warning,
        );
        return emptyStatus;
      }

      try {
        dynamic decoded;
        if (isGet && streamBody == null) {
          decoded = json.decode(utf8.decoder.convert(res.bodyBytes));
        } else {
          decoded = json.decode(body);
        }

        if (decoded is Map<String, dynamic>) {
           return decoded;
        } else if (decoded is List) {
           return {"status": "success", "data": decoded};
        } else {
           YurLog(
            generateDetailedLog("Format Exception", "Format response bukan Map/List"),
            name: "WARNING",
            level: Level.warning,
          );
          return emptyStatus;
        }
      } catch (e, stacktrace) {
        YurLog(
          generateDetailedLog("Parse Exception", "Invalid JSON Format", stacktrace),
          name: "ERROR",
          level: Level.error,
        );
        emptyStatus["message"] = "Format data tidak valid";
        return emptyStatus;
      }
    } catch (e, stacktrace) {
      stopwatch.stop();
      YurLog(
        '''
Timestamp: ${DateTime.now().toIso8601String()}
API Endpoint: $urlHttp
HTTP Method: $httpMethod
Status Code: $statusCode
Request Header: $headers
Request Body: ${dataMap.toString()}
Response Time: ${stopwatch.elapsedMilliseconds}ms
Error Type: Exception
Error Message: ${e.toString().trim()}
Stacktrace: $stacktrace
Response Body: ${body.length > 1000 ? body.substring(0, 1000) + '...' : body}
''',
        name: "ERROR",
        level: Level.error,
      );
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
