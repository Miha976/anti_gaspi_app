import 'package:go_router/go_router.dart';
import 'package:anti_gaspi_app/screens/inventory/inventory_screen.dart';
import 'package:anti_gaspi_app/screens/add_product/add_product_screen.dart';
import 'package:anti_gaspi_app/screens/declare_waste/declare_waste_screen.dart';
import 'package:anti_gaspi_app/screens/statistics/statistics_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const InventoryScreen()),
    GoRoute(
      path: '/add',
      builder: (context, state) => const AddProductScreen(),
    ),
    GoRoute(
      path: '/waste/:productId',
      builder: (context, state) {
        final productId = int.parse(state.pathParameters['productId']!);
        return DeclareWasteScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/stats',
      builder: (context, state) => const StatisticsScreen(),
    ),
  ],
);
