import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show OrderingTerm, OrderingMode, Value;
import 'package:anti_gaspi_app/database/database.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  _ExpiryInfo _expiryInfo(DateTime? expiryDate) {
    if (expiryDate == null) {
      return _ExpiryInfo(
        label: 'Pas de DLC',
        color: const Color(0xFF9E9E9E),
        backgroundColor: const Color(0xFFF5F5F5),
      );
    }
    final days = expiryDate.difference(DateTime.now()).inDays;
    if (days < 0) {
      return _ExpiryInfo(
        label: 'Périmé',
        color: Colors.white,
        backgroundColor: const Color(0xFFE07A5F),
      );
    }
    if (days == 0) {
      return _ExpiryInfo(
        label: 'Expire aujourd\'hui',
        color: Colors.white,
        backgroundColor: const Color(0xFFE07A5F),
      );
    }
    if (days <= 3) {
      return _ExpiryInfo(
        label: 'Dans $days jour${days > 1 ? 's' : ''}',
        color: const Color(0xFF7B3F00),
        backgroundColor: const Color(0xFFFFF0E6),
      );
    }
    return _ExpiryInfo(
      label: 'Dans $days jours',
      color: const Color(0xFF2D6A4F),
      backgroundColor: const Color(0xFFE8F5EE),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Légumes':
        return Icons.eco_outlined;
      case 'Fruits':
        return Icons.lunch_dining_outlined;
      case 'Produits laitiers':
        return Icons.water_drop_outlined;
      case 'Viandes et poissons':
        return Icons.set_meal_outlined;
      case 'Boissons':
        return Icons.local_drink_outlined;
      case 'Restes cuisinés':
        return Icons.restaurant_outlined;
      default:
        return Icons.inventory_2_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon frigo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            onPressed: () => context.push('/stats'),
          ),
          const SizedBox(width: 8),
        ],
      ),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.kitchen_outlined,
                    size: 64,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Frigo vide',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ajoute tes courses pour commencer',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 100),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final info = _expiryInfo(product.expiryDate);

              return Dismissible(
                key: ValueKey(product.id),
                background: _SwipeBackground(
                  color: const Color(0xFF2D6A4F),
                  icon: Icons.check_rounded,
                  alignment: Alignment.centerLeft,
                ),
                secondaryBackground: _SwipeBackground(
                  color: const Color(0xFFE07A5F),
                  icon: Icons.delete_outline_rounded,
                  alignment: Alignment.centerRight,
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    await (db.update(
                      db.products,
                    )..where((p) => p.id.equals(product.id))).write(
                      const ProductsCompanion(isConsumed: Value(true)),
                    );
                  } else {
                    context.push('/waste/${product.id}');
                  }
                  return false;
                },
                child: Card(
                  child: GestureDetector(
                    onTap: () => context.push('/product/${product.id}'),
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5EE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _categoryIcon(product.category),
                            color: const Color(0xFF2D6A4F),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                product.category,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: info.backgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              info.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: info.color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add'),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Ajouter',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _ExpiryInfo {
  final String label;
  final Color color;
  final Color backgroundColor;
  _ExpiryInfo({
    required this.label,
    required this.color,
    required this.backgroundColor,
  });
}

class _SwipeBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Alignment alignment;

  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Icon(icon, color: Colors.white, size: 26),
    );
  }
}
