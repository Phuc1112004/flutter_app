import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giỏ hàng của bạn'),
      ),
      body: cart.isEmpty
          ? Center(
        child: Text('Giỏ hàng của bạn đang trống.'),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          var product = cart[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text('Price: \$${product.price}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                // Xử lý logic xóa sản phẩm khỏi giỏ hàng
                // Chú ý: Để thực hiện xóa, bạn cần làm cho `CartScreen` thành `StatefulWidget`
              },
            ),
          );
        },
      ),
    );
  }
}
