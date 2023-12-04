import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas_teste/core/local_storage/local_storage.dart';

class SharedPreferencesAdapterImpl implements LocalStorage {
  SharedPreferencesAdapterImpl();

  @override
  Future<void> saveData(String keyValue, String valueToCache) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyValue, valueToCache);
    debugPrint('Salvo: $valueToCache');
  }

  @override
  Future<String> fetchData(String keyValue) async {
    final prefs = await SharedPreferences.getInstance();
    final stringData = prefs.getString(keyValue);

    if (stringData != null) {
      debugPrint('Encontrado: $stringData');
      return Future.value(stringData);
    } else {
      throw Exception('Exception fetching data.');
    }
  }

  @override
  Future<void> deleteData(String keyValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyValue);
  }

  @override
  Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<void> saveListData(String keyValue, List<String> listToCache) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(keyValue, listToCache);
  }

  @override
  Future<List<String>> fetchListData(String keyValue) async {
    final prefs = await SharedPreferences.getInstance();
    final stringData = prefs.getStringList(keyValue);

    if (stringData != null) {
      return Future.value(stringData);
    } else {
      throw Exception('Exception fetching data.');
    }
  }
}
