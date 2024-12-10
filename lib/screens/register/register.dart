import 'package:flutter/material.dart';
import 'package:pkl_project/services/auth_service.dart';
import 'package:pkl_project/widgets/rounded_inputfield.dart';
import 'package:pkl_project/screens/login/login.dart';
import 'package:pkl_project/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  void register() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      try {
        var user = await authService.registerWithEmailPassword(email, password);
        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration successful!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              RoundedTextField(
                controller: emailController,
                label: 'Email',
                icon: Icons.email,
                validator: Validators.validateEmail, // Validasi email
              ),
              SizedBox(height: 16),
              RoundedTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
                validator: Validators.validatePassword, // Validasi password
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: register,
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}