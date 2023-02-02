import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:master_class/my_app.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(isPreviewMode: true),
      ),
    );
