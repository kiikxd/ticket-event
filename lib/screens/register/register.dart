import 'package:flutter/material.dart';
import 'package:pkl_project/services/authService.dart';
import 'package:pkl_project/widgets/rounded_inputfield.dart';
import 'package:pkl_project/widgets/rounded_button.dart';
import 'package:pkl_project/screens/login/login.dart';
import 'package:pkl_project/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  void register() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;

      try {
        var user = await authService.registerWithEmailPassword(
          email, password,firstName, lastName);
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
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center( // Pusatkan isi layar
        child: SingleChildScrollView( // Scroll untuk menjaga layout tetap responsif
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Register Sevent',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                RoundedTextField(
                  controller: firstNameController,
                  label: 'First Name',
                  icon: Icons.person,
                  validator: Validators.validateName, // Custom validator for first name
                ),
                SizedBox(height: 16),
                RoundedTextField(
                  controller: lastNameController,
                  label: 'Last Name',
                  icon: Icons.person,
                  validator: Validators.validateName,
                ),
                SizedBox(height: 16),
                RoundedTextField(
                  controller: emailController,
                  label: 'Email',
                  icon: Icons.email,
                  validator: Validators.validateEmail,
                ),
                SizedBox(height: 16),
                RoundedTextField(
                  controller: passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),
                SizedBox(height: 16),
                RoundedTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) =>
                      Validators.validateConfirmPassword(value, passwordController.text),
                ),
                SizedBox(height: 16),
                RoundedButton(
                  text: 'Register',
                  onPressed: register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
