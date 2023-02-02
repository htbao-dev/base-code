//this class is implement Hive to save local

import 'package:hive_flutter/hive_flutter.dart';

class Hivehelper {
  static Hivehelper? _instance;
  Hivehelper._internal();
  factory Hivehelper() {
    _instance ??= Hivehelper._internal();
    return _instance!;
  }

  static Future<void> init() async {
    await Hive.initFlutter();
  }

  void dispose() {}
}
