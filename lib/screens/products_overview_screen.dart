import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/product_item.dart';
import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: Text('${cart.items.length}'),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false).fetchProducts(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<ProductsProvider>(
              builder: (ctx, productsData, _) {
                if (productsData.items.isEmpty) {
                  return Center(child: Text('No products found.'));
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: productsData.items.length,
                  itemBuilder: (ctx, i) => ProductItem(productsData.items[i]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
