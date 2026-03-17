import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text('john.doe@example.com', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 32),
          const Text('APP SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
          const Divider(),
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Enable/Disable app notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Toggle between light and dark themes'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {}, // Empty callback
          ),
        ],
      ),
    );
  }
}
