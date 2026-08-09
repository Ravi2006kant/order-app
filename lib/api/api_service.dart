import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = "https://dummyjson.com";
  Future<List<dynamic>> getProducts() async {
    final response = await http.get(Uri.parse("$apiUrl/products"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['products'];
    } else {
      throw Exception('failed to load the products');
    }
  }

  Future<List<dynamic>> getCateogry() async {
    final response = await http.get(Uri.parse("$apiUrl/products/categories"));
    final data = jsonDecode(response.body);

    return data;
  }

  Future<List<dynamic>> getProductByCateogry(String slug) async {
    final response = await http.get(
      Uri.parse("$apiUrl/products/category/$slug"),
    );
    final data = jsonDecode(response.body);

    return data['products'];
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
  final response = await http.get(
    Uri.parse("$apiUrl/products/$id"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load product details');
  }
}
}
