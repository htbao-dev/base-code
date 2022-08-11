import 'package:dapass/presentation/login/login_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
    // throw Exception('Invalid route: ${settings.name}');
  }
}
