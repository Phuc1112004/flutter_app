class CartItem {
  final int id;
  final int productId;
  final String productName;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
  });
}