import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:anti_gaspi_app/database/database.dart';
import 'package:anti_gaspi_app/services/open_food_facts_service.dart';

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

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Légumes', 'icon': Icons.eco_outlined},
    {'label': 'Fruits', 'icon': Icons.lunch_dining_outlined},
    {'label': 'Produits laitiers', 'icon': Icons.water_drop_outlined},
    {'label': 'Viandes et poissons', 'icon': Icons.set_meal_outlined},
    {'label': 'Épicerie', 'icon': Icons.inventory_2_outlined},
    {'label': 'Boissons', 'icon': Icons.local_drink_outlined},
    {'label': 'Restes cuisinés', 'icon': Icons.restaurant_outlined},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
    if (picked != null) setState(() => _expiryDate = picked);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final db = context.read<AppDatabase>();
    await db.into(db.products).insert(
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
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                      onPressed: () => setState(() => _isScanning = false),
                    ),
                  ),
                ),
              ],
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Bouton scanner
                  OutlinedButton.icon(
                    onPressed: _isLoading
                        ? null
                        : () => setState(() => _isScanning = true),
                    icon: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.qr_code_scanner_rounded),
                    label: Text(
                      _isLoading ? 'Recherche...' : 'Scanner un code-barre',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2D6A4F),
                      side: const BorderSide(
                          color: Color(0xFF2D6A4F), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'ou saisir manuellement',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade400),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Champ nom
                  _FieldLabel(label: 'Nom du produit'),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: _inputDecoration('Ex : Yaourt nature'),
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Champ obligatoire'
                        : null,
                  ),

                  const SizedBox(height: 20),

                  // Catégorie en chips
                  _FieldLabel(label: 'Catégorie'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((cat) {
                      final isSelected = _selectedCategory == cat['label'];
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = cat['label']),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF2D6A4F)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF2D6A4F)
                                  : Colors.grey.shade200,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                cat['icon'] as IconData,
                                size: 15,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade500,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                cat['label'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Date de péremption
                  _FieldLabel(label: 'Date de péremption (optionnelle)'),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: _pickExpiryDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_outlined,
                              size: 18, color: const Color(0xFF2D6A4F)),
                          const SizedBox(width: 12),
                          Text(
                            _expiryDate == null
                                ? 'Choisir une date'
                                : '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}',
                            style: TextStyle(
                              fontSize: 15,
                              color: _expiryDate == null
                                  ? Colors.grey.shade400
                                  : const Color(0xFF1A1A1A),
                              fontWeight: _expiryDate == null
                                  ? FontWeight.normal
                                  : FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          if (_expiryDate != null)
                            GestureDetector(
                              onTap: () => setState(() => _expiryDate = null),
                              child: Icon(Icons.close,
                                  size: 16, color: Colors.grey.shade400),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Bouton valider
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text(
                      'Ajouter à l\'inventaire',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(color: Color(0xFF2D6A4F), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE07A5F)),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF555555),
        letterSpacing: 0.2,
      ),
    );
  }
}