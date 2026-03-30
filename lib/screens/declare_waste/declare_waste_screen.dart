import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:anti_gaspi_app/database/database.dart';

class DeclareWasteScreen extends StatefulWidget {
  final int productId;
  const DeclareWasteScreen({super.key, required this.productId});

  @override
  State<DeclareWasteScreen> createState() => _DeclareWasteScreenState();
}

class _DeclareWasteScreenState extends State<DeclareWasteScreen> {
  String? _selectedReason;
  String _selectedQuantity = 'tout';
  final List<Map<String, dynamic>> _reasons = [
    {
      'label': 'Périmé',
      'description': 'La date limite était dépassée',
      'icon': Icons.schedule_outlined,
    },
    {
      'label': 'Pas aimé',
      'description': 'Le goût ne convenait pas',
      'icon': Icons.sentiment_dissatisfied_outlined,
    },
    {
      'label': 'Trop cuisiné',
      'description': 'On en a préparé plus que nécessaire',
      'icon': Icons.restaurant_outlined,
    },
    {
      'label': 'Oublié',
      'description': 'Il est resté au fond du frigo',
      'icon': Icons.visibility_off_outlined,
    },
  ];
  final List<Map<String, dynamic>> _quantities = [
    {
      'label': 'tout',
      'display': 'Tout',
      'description': 'Le produit entier',
      'icon': Icons.delete_sweep_outlined,
      'weight': 1.0,
    },
    {
      'label': 'moitié',
      'display': 'La moitié',
      'description': 'Environ 50% du produit',
      'icon': Icons.pie_chart_outline_rounded,
      'weight': 0.5,
    },
    {
      'label': 'un peu',
      'display': 'Un peu',
      'description': 'Une petite partie',
      'icon': Icons.data_usage_rounded,
      'weight': 0.25,
    },
  ];

  Future<void> _confirm(AppDatabase db, Product product) async {
    if (_selectedReason == null) return;

    await db
        .into(db.wasteEvents)
        .insert(
          WasteEventsCompanion.insert(
            productName: product.name,
            category: product.category,
            reason: _selectedReason!,
            quantity: Value(_selectedQuantity),
            date: DateTime.now(),
          ),
        );

    await (db.update(db.products)..where((p) => p.id.equals(widget.productId)))
        .write(const ProductsCompanion(isConsumed: Value(true)));

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(title: const Text('Déclarer un jet')),
      body: FutureBuilder<Product>(
        future: (db.select(
          db.products,
        )..where((p) => p.id.equals(widget.productId))).getSingle(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Produit concerné
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF0E6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE07A5F).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE07A5F).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFE07A5F),
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
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Pourquoi le jettes-tu ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555555),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ..._reasons.map((reason) {
                      final isSelected = _selectedReason == reason['label'];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedReason = reason['label']),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFE07A5F)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFE07A5F)
                                  : Colors.grey.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                reason['icon'] as IconData,
                                size: 22,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF2D6A4F),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reason['label'] as String,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1A1A1A),
                                      ),
                                    ),
                                    Text(
                                      reason['description'] as String,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isSelected
                                            ? Colors.white.withOpacity(0.8)
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),

                    const Text(
                      'Quelle quantité ?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF555555),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: _quantities.map((q) {
                        final isSelected = _selectedQuantity == q['label'];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedQuantity = q['label']),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE07A5F)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFFE07A5F)
                                      : Colors.grey.shade200,
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    q['icon'] as IconData,
                                    size: 22,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFFE07A5F),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    q['display'] as String,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    q['description'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.8)
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Bouton collé en bas
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: ElevatedButton(
                  onPressed: _selectedReason == null
                      ? null
                      : () => _confirm(db, product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE07A5F),
                    disabledBackgroundColor: Colors.grey.shade200,
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: const Text(
                    'Confirmer le jet',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
