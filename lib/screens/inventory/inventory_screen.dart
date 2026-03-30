import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:anti_gaspi_app/database/database.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  Color _expiryColor(DateTime? expiryDate) {
    if (expiryDate == null) return Colors.grey;
    final days = expiryDate.difference(DateTime.now()).inDays;
    if (days <= 2) return Colors.red;
    if (days <= 5) return Colors.orange;
    return Colors.green;
  }

  String _expiryLabel(DateTime? expiryDate) {
    if (expiryDate == null) return 'Pas de DLC';
    final days = expiryDate.difference(DateTime.now()).inDays;
    if (days < 0) return 'Périmé';
    if (days == 0) return 'Expire aujourd\'hui';
    if (days == 1) return 'Expire demain';
    return 'Expire dans $days jours';
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(title: const Text('Inventaire')),
      body: StreamBuilder<List<Product>>(
        stream:
            (db.select(db.products)
                  ..where((p) => p.isConsumed.equals(false))
                  ..orderBy([
                    (p) => OrderingTerm(
                      expression: p.expiryDate,
                      mode: OrderingMode.asc,
                    ),
                  ]))
                .watch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text('Aucun produit dans l\'inventaire.'),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final color = _expiryColor(product.expiryDate);
              final label = _expiryLabel(product.expiryDate);

              return Dismissible(
                key: ValueKey(product.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete_outline, color: Colors.white),
                ),
                confirmDismiss: (_) async {
                  context.push('/waste/${product.id}');
                  return false;
                },
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: color, radius: 8),
                  title: Text(product.name),
                  subtitle: Text(product.category),
                  trailing: Text(
                    label,
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
