import 'package:flutter/material.dart';
import 'package:product_app_api/models/product.dart';
import 'package:product_app_api/service/api_service.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
    )
  }
}

