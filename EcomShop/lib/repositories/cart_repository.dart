import 'package:ecomshop/database/db_helper.dart';
import 'package:ecomshop/models/cart_item.dart';

class CartRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<void> addToCart(CartItem cartItem) async {
    await _dbHelper.insert('cart', {
      'productId': cartItem.productId,
      'productName': cartItem.productName,
      'price': cartItem.price,
      'quantity': cartItem.quantity,
    });
  }

  Future<List<CartItem>> getCartItems() async {
    final cartItems = await _dbHelper.queryAll('cart');
    return cartItems.map((item) {
      return CartItem(
        id: item['id'],
        productId: item['productId'],
        productName: item['productName'],
        price: item['price'],
        quantity: item['quantity'],
      );
    }).toList();
  }

  Future<void> removeFromCart(int id) async {
    await _dbHelper.delete('cart', id);
  }
}