import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class ProductService {
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('/shoppingcart/zjFNbaRba7aUNTENQaM4');

  Future<List<Product>> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot = await _productsCollection.get();
      return querySnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
