import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductResult {
  final String? name;
  final String? category;

  ProductResult({this.name, this.category});
}

class OpenFoodFactsService {
  static const _categoryMap = {
    'en:vegetables': 'Légumes',
    'en:fruits': 'Fruits',
    'en:dairies': 'Produits laitiers',
    'en:meats': 'Viandes et poissons',
    'en:seafood': 'Viandes et poissons',
    'en:beverages': 'Boissons',
  };

  static String _mapCategory(List<dynamic>? categories) {
    if (categories == null) return 'Épicerie';
    for (final cat in categories) {
      final mapped = _categoryMap[cat];
      if (mapped != null) return mapped;
    }
    return 'Épicerie';
  }

  static Future<ProductResult?> fetchByBarcode(String barcode) async {
    try {
      final url = Uri.parse(
        'https://world.openfoodfacts.org/api/v2/product/$barcode?fields=product_name,categories_tags',
      );
      final response = await http.get(url);
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      if (data['status'] != 1) return null;

      final product = data['product'];
      return ProductResult(
        name: product['product_name'],
        category: _mapCategory(product['categories_tags']),
      );
    } catch (_) {
      return null;
    }
  }
}