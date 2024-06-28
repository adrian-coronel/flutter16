import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  final String productId;

  ProductDetailScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductsProvider>(context, listen: false).items.firstWhere((prod) => prod.id == productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addCartItem(product.id, 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to cart!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
