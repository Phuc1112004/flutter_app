import 'package:ecomshop/models/cart_item.dart';
import 'package:ecomshop/models/product.dart';
import 'package:ecomshop/providers/cart_provider.dart';
import 'package:ecomshop/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(id: 1, name: 'Product 1', price: 29.99, description: 'This is the description for Product 1.', saleDate: '2024-08-22', imageUrl: 'https://i.pinimg.com/736x/ba/2e/2c/ba2e2c1415cfa0cf633cc7cf4b6e0641.jpg'),
    Product(id: 2, name: 'Product 2', price: 19.99, description: 'This is the description for Product 2.', saleDate: '2024-08-23', imageUrl: 'https://i.pinimg.com/736x/ba/2e/2c/ba2e2c1415cfa0cf633cc7cf4b6e0641.jpg'),
    Product(id: 3, name: 'Product 3', price: 39.99, description: 'This is the description for Product 3.', saleDate: '2024-08-24', imageUrl: 'https://i.pinimg.com/736x/ba/2e/2c/ba2e2c1415cfa0cf633cc7cf4b6e0641.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('E-Commerce Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()), // Thay CartScreen bằng màn hình giỏ hàng của bạn
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) => ListTile(
          leading: Image.network(products[i].imageUrl, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(products[i].name),
          subtitle: Text('\$${products[i].price}'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () async {
              final cartItem = CartItem(
                id: 0,  // ID sẽ được tự động tạo ra trong cơ sở dữ liệu
                productId: products[i].id,
                productName: products[i].name,
                price: products[i].price,
                quantity: 1,
              );
              await cartProvider.addToCart(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${products[i].name} added to cart!'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
