import 'package:flutter/material.dart';
import 'package:pkl_project/services/auth_service.dart';
import 'package:pkl_project/widgets/rounded_inputfield.dart';
import 'package:pkl_project/widgets/rounded_button.dart';
import '../welcome/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    var user = await authService.signInWithEmailPassword(email, password);
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login Sevent',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  RoundedTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 16),
                  RoundedTextField(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 30),
                  RoundedButton(
                    text: 'Login',
                    onPressed: login,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
