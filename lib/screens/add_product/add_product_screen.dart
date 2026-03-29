import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:anti_gaspi_app/services/open_food_facts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:anti_gaspi_app/database/database.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _expiryDate;
  String _selectedCategory = 'Épicerie';
  bool _isScanning = false;
  bool _isLoading = false;

  final List<String> _categories = [
    'Légumes',
    'Fruits',
    'Produits laitiers',
    'Viandes et poissons',
    'Épicerie',
    'Boissons',
    'Restes cuisinés',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() => _isScanning = true);
  }

  void _onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode == null) return;

    setState(() {
      _isScanning = false;
      _isLoading = true;
    });

    final result = await OpenFoodFactsService.fetchByBarcode(barcode);

    setState(() {
      _isLoading = false;
      if (result != null) {
        if (result.name != null) _nameController.text = result.name!;
        if (result.category != null) _selectedCategory = result.category!;
      }
    });
  }

  Future<void> _pickExpiryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked != null) {
      setState(() => _expiryDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final db = context.read<AppDatabase>();

    await db
        .into(db.products)
        .insert(
          ProductsCompanion.insert(
            name: _nameController.text.trim(),
            category: _selectedCategory,
            expiryDate: Value(_expiryDate),
            addedDate: DateTime.now(),
          ),
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un produit')),
      body: _isScanning
          ? Stack(
              children: [
                MobileScanner(onDetect: _onDetect),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => setState(() => _isScanning = false),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _startScan,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.qr_code_scanner),
                      label: Text(
                        _isLoading ? 'Recherche...' : 'Scanner un code-barre',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom du produit',
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Champ obligatoire'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Catégorie'),
                      items: _categories
                          .map(
                            (cat) =>
                                DropdownMenuItem(value: cat, child: Text(cat)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null)
                          setState(() => _selectedCategory = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        _expiryDate == null
                            ? 'Date de péremption (optionnelle)'
                            : 'Péremption : ${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _pickExpiryDate,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Ajouter à l\'inventaire'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
