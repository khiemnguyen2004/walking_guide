import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // Thêm dòng này để khởi tạo Firebase
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:walking_guide/screens/auth/login_screen.dart';
import 'package:walking_guide/screens/home/home_screen.dart';

// Hàm main() là entrypoint của ứng dụng
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter đã khởi tạo
  await Firebase.initializeApp(); // Khởi tạo Firebase
  runApp(const MyApp()); // Chạy ứng dụng với MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}