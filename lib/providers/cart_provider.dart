import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  double _total = 0.0;

  List<CartItem> get items => [..._items];
  double get total => _total;

  Future<void> fetchCartItems() async {
    const url = 'http://localhost:3000/cart-items';
    try {
      final response = await http.get(Uri.parse(url));
      final responseData = json.decode(response.body);
      final extractedData = responseData['items'] as List<dynamic>;
      _items = extractedData.map((item) => CartItem.fromJson(item)).toList();
      _total = (responseData['total'] as num).toDouble();
      notifyListeners();
    } catch (error) {
      print('Error fetching cart items: $error');
    }
  }

  Future<void> addCartItem(String productId, int quantity) async {
    const url = 'http://localhost:3000/cart-items';
    try {
      print(productId is String);
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'productId': productId,
          'quantity': quantity,
        }),
      );
      print(response.body);
      final newCartItem = CartItem.fromJson(json.decode(response.body));
      print("cartitem: $newCartItem");
      _items.add(newCartItem);
      _total += newCartItem.price * newCartItem.quantity;
      notifyListeners();
    } catch (error) {
      print('Error adding cart item: $error');
    }
  }

  void clear() {
    _items = [];
    _total = 0.0;
    notifyListeners();
  }
}
