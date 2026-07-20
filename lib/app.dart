import 'package:flutter/material.dart';
import 'package:lilas_tamkeen_project/core/routing/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splash1,
      routes: AppRoutes.routes,
      locale: Locale("en"),
      supportedLocales: [Locale("en"), Locale("ar")],
      localizationsDelegates: const [],
      debugShowCheckedModeBanner: false,
    );
  }
}
