import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pkl_project/widgets/profile_avatar.dart';
import 'package:pkl_project/widgets/profile_menu_item.dart';
import 'package:pkl_project/screens/profile/setting.dart'; // Import SettingsScreen
import 'package:pkl_project/screens/profile/components/edit_profile.dart'; // Import SettingsScreen
import 'package:pkl_project/screens/login/login.dart';
import 'package:pkl_project/services/userService.dart'; // Import UserService


class ProfileScreen extends StatefulWidget {
  final Function(String) onUsernameUpdated; // Update tipe callback

  const ProfileScreen({Key? key, required this.onUsernameUpdated})
      : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> userDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture = UserService().getUserData();
  }

  // Fungsi untuk memuat ulang data setelah update
  void reloadUserData(String newUsername) {
    setState(() {
      userDataFuture = UserService().getUserData();
    });
    widget.onUsernameUpdated(newUsername);  // Panggil dengan parameter username
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No user data found.'));
          }

          Map<String, dynamic> userData = snapshot.data!;
          String username = userData['username'] ?? 'No username';
          String email = userData['email'] ?? 'No email';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfileAvatar(
                    imageUrl: 'https://via.placeholder.com/150',
                    name: username,
                    email: email,
                  ),
                  const SizedBox(height: 32),
                  ProfileMenuItem(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            reloadUserData: reloadUserData,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ProfileMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Logout', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
