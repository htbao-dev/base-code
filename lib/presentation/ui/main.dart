import 'package:flutter/material.dart';
import 'package:master_class/helper/hive_helper.dart';

import '../../my_app.dart';

void main() async {
  await Hivehelper.init();
  runApp(const MyApp());
}
