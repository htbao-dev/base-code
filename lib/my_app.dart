import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:device_preview/device_preview.dart';

import 'helper/api_helper.dart';

class MyApp extends StatelessWidget {
  final bool isPreviewMode;
  const MyApp({super.key, this.isPreviewMode = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: isPreviewMode,
      locale: isPreviewMode ? DevicePreview.locale(context) : null,
      builder: isPreviewMode ? DevicePreview.appBuilder : null,
      home: const MyHomePage(
        title: 'master class',
      ),
    );
  }
}

class FlavorParameter {
  final String flavor;
  final String domainAPI;
  FlavorParameter({
    required this.flavor,
    required this.domainAPI,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    ApiHelperImpl apiHandlerImpl = ApiHelperImpl();
    apiHandlerImpl
        .getMethod('http://dev.vanbao.online/api/v1/public/app/getVersion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
