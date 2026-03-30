import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anti_gaspi_app/database/database.dart';
import 'package:anti_gaspi_app/router/app_router.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2D6A4F),
            brightness: Brightness.light,
            surface: const Color(0xFFF7F4EF),
          ),
          scaffoldBackgroundColor: const Color(0xFFF7F4EF),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF7F4EF),
            elevation: 0,
            scrolledUnderElevation: 0,
            titleTextStyle: TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            iconTheme: IconThemeData(color: Color(0xFF2D6A4F)),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF2D6A4F),
            foregroundColor: Colors.white,
            elevation: 2,
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D6A4F),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}