import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/cart_service.dart';
import 'ForgotPasswordPageScreen.dart';

class LoginPage extends StatefulWidget {
  final CartService cartService;

  LoginPage({required this.cartService});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? errorMessage;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/home'); // Điều hướng sau khi đăng nhập thành công
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register'); // Điều hướng đến trang đăng ký
              },
              child: Text('Don\'t have an account? Register here'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot_password'); // Điều hướng đến trang quên mật khẩu
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
