import 'package:anti_gaspi_app/database/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeclareWasteScreen extends StatefulWidget {
  final int productId;

  const DeclareWasteScreen({super.key, required this.productId});

  @override
  State<DeclareWasteScreen> createState() => _DeclareWasteScreenState();
}

class _DeclareWasteScreenState extends State<DeclareWasteScreen> {
  String? _selectedReason;

  final List<String> _reasons = [
    'Périmé',
    'Pas aimé',
    'Trop cuisiné',
    'Oublié',
  ];

  Future<void> _confirm() async {
    if (_selectedReason == null) return;

    final db = context.read<AppDatabase>();

    final product = await (db.select(db.products)
          ..where((p) => p.id.equals(widget.productId)))
        .getSingle();

    await db.into(db.wasteEvents).insert(
          WasteEventsCompanion.insert(
            productName: product.name,
            category: product.category,
            reason: _selectedReason!,
            date: DateTime.now(),
          ),
        );

    await (db.update(db.products)
          ..where((p) => p.id.equals(widget.productId)))
        .write(const ProductsCompanion(isConsumed: Value(true)));

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Déclarer un jet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pourquoi jettes-tu ce produit ?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._reasons.map(
              (reason) => RadioListTile<String>(
                title: Text(reason),
                value: reason,
                groupValue: _selectedReason,
                onChanged: (value) => setState(() => _selectedReason = value),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selectedReason == null ? null : _confirm,
              child: const Text('Confirmer le jet'),
            ),
          ],
        ),
      ),
    );
  }
}