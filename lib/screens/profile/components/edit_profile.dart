import 'package:flutter/material.dart';
import 'package:pkl_project/widgets/rounded_inputfield.dart';
import 'package:pkl_project/services/profileService.dart';
import 'package:pkl_project/widgets/confirmation_delete.dart';
import 'package:pkl_project/screens/login/login.dart';


class EditProfileScreen extends StatefulWidget {
  final Function(String) reloadUserData; // Callback untuk reload username

  const EditProfileScreen({Key? key, required this.reloadUserData}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileService _profileService = ProfileService();
  late TextEditingController usernameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      Map<String, dynamic> userData = await _profileService.loadUserData();
      usernameController.text = userData['username'] ?? '';
      emailController.text = userData['email'] ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  Future<void> _updateUserData() async {
    try {
      await _profileService.updateUserData(
        username: usernameController.text,
        email: emailController.text,
      );
      widget.reloadUserData(usernameController.text);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  Future<void> _deleteAccount() async {
  try {
    await _profileService.deleteAccount();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false,
    );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete account: $e')),
      );
    }
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: 'Delete Account',
        content: 'Are you sure you want to delete your account? This action cannot be undone.',
        onConfirm: _deleteAccount,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RoundedTextField(
              controller: usernameController,
              label: 'Username',
              icon: Icons.person,
            ),
            SizedBox(height: 20),    
            RoundedTextField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              child: const Text('Update Profile'),
            ),
            TextButton(
              onPressed: _confirmDeleteAccount,
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
