import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/datamodel.dart';

class ApiService {
  static const String baseUrl =
      'http://esptiles.imperoserver.in/api/API/Product/DashBoard';

  Future<List<Category>> fetchCategories() async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'CategoryId': 0,
        'DeviceManufacturer': 'Google',
        'DeviceModel': 'Android SDK built for x86',
        'DeviceToken': ' ',
        'PageIndex': 1,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Category> categories = (data["Result"]['Category'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<SubCategory>> fetchSubCategories(int categoryId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'CategoryId': categoryId,
        'PageIndex': 1,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<SubCategory> subCategories =
          (data["Result"]["Category"][0]['SubCategories'] as List)
              .map((json) => SubCategory.fromJson(json))
              .toList();
      return subCategories;
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<List<Product>> fetchProducts(int subCategoryId) async {
    final response = await http.post(
      Uri.parse('http://esptiles.imperoserver.in/api/API/Product/ProductList'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'PageIndex': 1,
        'SubCategoryId': subCategoryId,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products = (data["Result"] as List)
          .map((json) => Product.fromJson(json))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
