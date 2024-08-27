import 'package:ecomshop/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(cartItems[i].productName),
          subtitle: Text('${cartItems[i].quantity} x \$${cartItems[i].price}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              cartProvider.removeFromCart(cartItems[i].id);
            },
          ),
        ),
      ),
    );
  }
}