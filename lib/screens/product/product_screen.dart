import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:anti_gaspi_app/database/database.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _expiryDate;
  String _selectedCategory = 'Épicerie';
  bool _loaded = false;

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

  Future<Product> _loadProduct(AppDatabase db) async {
    return (db.select(db.products)
          ..where((p) => p.id.equals(widget.productId)))
        .getSingle();
  }

  void _prefill(Product product) {
    if (_loaded) return;
    _nameController.text = product.name;
    _selectedCategory = product.category;
    _expiryDate = product.expiryDate;
    _loaded = true;
  }

  Future<void> _pickExpiryDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  Future<void> _save(AppDatabase db) async {
    if (!_formKey.currentState!.validate()) return;

    await (db.update(db.products)
          ..where((p) => p.id.equals(widget.productId)))
        .write(ProductsCompanion(
      name: Value(_nameController.text.trim()),
      category: Value(_selectedCategory),
      expiryDate: Value(_expiryDate),
    ));

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete(AppDatabase db) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Supprimer ce produit ?'),
        content: const Text(
            'Il sera retiré de l\'inventaire sans être comptabilisé comme un jet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFE07A5F)),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await (db.delete(db.products)
            ..where((p) => p.id.equals(widget.productId)))
          .go();
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier le produit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                color: Color(0xFFE07A5F)),
            onPressed: () => _delete(db),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<Product>(
        future: _loadProduct(db),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = snapshot.data!;
          _prefill(product);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
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

                // Catégorie
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

                ElevatedButton(
                  onPressed: () => _save(db),
                  child: const Text(
                    'Enregistrer les modifications',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
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