import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Pastikan untuk menambahkan provider di pubspec.yaml

import 'package:pkl_project/services/theme_notifier.dart';  // Import ThemeNotifier

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Switch
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: Provider.of<ThemeNotifier>(context).isDarkMode,
                onChanged: (value) {
                  // Toggle theme
                  Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
                },
              ),
            ),
            const Divider(),

            // Other settings items can be added here
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                // Navigate to notification settings
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to help & support
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
