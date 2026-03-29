import 'package:flutter/material.dart';
import 'package:anti_gaspi_app/router/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anti Gaspi',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}