class CartItem {
  final String id;
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final productData = json['productId'];
    return CartItem(
      id: json['_id'] as String,
      productId: productData['_id'] as String,
      name: productData['name'] as String,
      quantity: json['quantity'] as int,
      price: (productData['price'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'CartItem{id: $id, productId: $productId, name: $name, quantity: $quantity, price: $price}';
  }
}
