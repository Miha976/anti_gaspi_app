import 'package:anti_gaspi_app/database/database.dart';
import 'package:flutter/material.dart';
import 'package:anti_gaspi_app/app.dart';
import 'package:anti_gaspi_app/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  final database = AppDatabase();
  runApp(App(database: database));
}