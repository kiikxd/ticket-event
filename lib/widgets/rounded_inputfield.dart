import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final IconData icon;
  final String? Function(String?)? validator; // Tambahkan validator

  const RoundedTextField({
    required this.controller,
    required this.label,
    this.obscureText = false,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator, // Panggil validator
    );
  }
}
