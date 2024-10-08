import 'dart:convert';

import 'package:sayur_widget/sayur_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GET & SET <==================================
Future<T> getShared<T>({required String key, required T defaultValue}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    final value = prefs.getString(key);

    return value != null ? json.decode(value) as T : defaultValue;
  } catch (e) {
    YurLog(name: "_getShared", e.toString());
    return defaultValue;
  }
}

Future<bool> setShared<T>({required String key, required T value}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String valueJson = json.encode(value);
    var reloadedValue = await prefs.setString(key, valueJson);
    prefs.reload();

    return reloadedValue;
  } catch (e) {
    YurLog(name: "_getShared", e.toString());

    return false;
  }
}

// CLEAR <==================================
Future<bool> clearSharedPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();

  return await prefs.clear();
}

// REMOVE <==================================
Future<bool> removeSharedPref({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.reload();
  return await prefs.remove(key);
}

//  BOOLEAN <==================================
Future<bool> getSharedBool({required String key}) async {
  bool? value = await getShared<bool>(key: key, defaultValue: false);
  return value;
}

Future<bool> setSharedBool({required String key, required bool value}) async {
  return await setShared<bool>(key: key, value: value);
}

//  STRING <==================================
Future<String> getSharedString({required String key}) async {
  return await getShared<String>(key: key, defaultValue: '');
}

Future<bool> setSharedString(
    {required String key, required String setStringTo}) async {
  return await setShared<String>(key: key, value: setStringTo);
}

//  INT <==================================
Future<int> getSharedInt({required String key}) async {
  return await getShared<int>(key: key, defaultValue: 0);
}

Future<bool> setSharedInt({required String key, required int setIntTo}) async {
  return await setShared<int>(key: key, value: setIntTo);
}

//  DOUBLE <==================================
Future<double> getSharedDouble({required String key}) async {
  return await getShared<double>(key: key, defaultValue: 0.0);
}

Future<bool> setSharedDouble(
    {required String key, required double setDoubleTo}) async {
  return await setShared<double>(key: key, value: setDoubleTo);
}

//  LIST <==================================
Future<List<String>> getSharedList(
    {required String key, required List<String> defaultValue}) async {
  return await getShared<List<String>>(key: key, defaultValue: defaultValue);
}

Future<bool> setSharedList(
    {required String key, required List<String> setListTo}) async {
  return await setShared<List<String>>(key: key, value: setListTo);
}

// DateTime <==================================
Future<DateTime> getSharedDateTime({required String key}) async {
  return await getShared<DateTime>(key: key, defaultValue: DateTime.now());
}

Future<bool> setSharedDateTime(
    {required String key, required DateTime setDateTimeTo}) async {
  return await setShared<DateTime>(key: key, value: setDateTimeTo);
}
