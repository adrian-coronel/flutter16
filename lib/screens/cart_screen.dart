import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    //print(cart.items[0].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              cart.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.total.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headlineSmall!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      // Lógica para realizar el pedido
                    },
                    child: Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => Card(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text('\$${cart.items[i].price}'),
                        ),
                      ),
                    ),
                    title: Text(cart.items[i].name),
                    subtitle: Text('Total: \$${(cart.items[i].price * cart.items[i].quantity)}'),
                    trailing: Text('${cart.items[i].quantity} x'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
