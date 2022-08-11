import 'package:dapass/dependency_injection.dart';
import 'package:dapass/routes/generate_route.dart';
import 'package:dapass/styles/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DependencyInjection(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildAppLightTheme(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
