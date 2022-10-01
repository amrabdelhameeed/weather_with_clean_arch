import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'constants.dart';

class LocationDatabase {
  static final _box = Hive.box<String>(AppStrings.locationsKey);
  static Future<void> addLocation(String location) async {
    await _box.put(location, location);
  }

  static List<String> getAllCites() => _box.values.toList();
  static Future<void> clearAll() => _box.clear();
  static Future<void> deleteLocation(String location) async => await _box.delete(location);
  static ValueListenable<Box<String>> listenable() => _box.listenable();
}
