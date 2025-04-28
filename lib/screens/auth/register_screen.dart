import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/firebase_service.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService _authService = AuthService();
  final FirebaseService _firebaseService = FirebaseService();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Tên")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: "Mật khẩu")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var user = await _authService.signUp(
                    emailController.text, passwordController.text);
                if (user != null) {
                  await _firebaseService.saveUser(user.uid, nameController.text, emailController.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đăng ký thất bại")));
                }
              },
              child: const Text("Đăng ký"),
            ),
          ],
        ),
      ),
    );
  }
}
