import 'product.dart';
import 'product_data.dart';
import 'package:flutter/material.dart';


class ProductListScreen extends StatelessWidget{
  // const ({Key? key}):super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          final product = products[index];
          return Card(
            // margin: ,
            child: ListTile()
          );
        }
      ),
    );
  }
  

}