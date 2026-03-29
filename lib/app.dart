import 'package:anti_gaspi_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:anti_gaspi_app/router/app_router.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final AppDatabase database;

  const App({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (_) => database,
      child: MaterialApp.router(
        title: 'Anti Gaspi',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
