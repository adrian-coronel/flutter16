import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => [..._items];

  Future<void> fetchProducts() async {
    const url = 'http://localhost:3000/products';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as List<dynamic>;
      _items = extractedData.map((item) => Product.fromJson(item)).toList();
      notifyListeners();
    } catch (error) {
      print('Error fetching products: $error');
    }
  }
}
