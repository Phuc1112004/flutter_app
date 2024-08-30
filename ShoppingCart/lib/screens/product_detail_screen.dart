import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    // Thực hiện hành động thêm sản phẩm vào giỏ hàng
    Navigator.pop(context, widget.product); // Trả về sản phẩm cho màn hình trước
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product.imageUrl),
            SizedBox(height: 16),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Price: \$${widget.product.price}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Sale Date: ${widget.product.saleDate}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(widget.product.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  onPressed: _decreaseQuantity,
                  icon: Icon(Icons.remove),
                ),
                Text(_quantity.toString(), style: TextStyle(fontSize: 18)),
                IconButton(
                  onPressed: _increaseQuantity,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addToCart,
              child: Text('Thêm vào giỏ hàng'),
            ),
          ],
        ),
      ),
    );
  }
}
