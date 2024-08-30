import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/product_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo rằng các dịch vụ gốc đã được khởi tạo
  try {
    await Firebase.initializeApp(); // Khởi tạo Firebase
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(),
    );
  }
}

