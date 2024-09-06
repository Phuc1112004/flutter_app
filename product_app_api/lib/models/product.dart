class Product {
  final String id;
  final int price;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'description': description,
    };
  }
}
