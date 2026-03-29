import 'package:anti_gaspi_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:anti_gaspi_app/router/app_router.dart';

class App extends StatelessWidget {
  final AppDatabase database;

  const App({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anti Gaspi',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}