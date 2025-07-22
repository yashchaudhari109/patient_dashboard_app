import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notifEnabled = true;

  @override
  Widget build(BuildContext context) {
    // For demonstration, hard-code patient info
    const String fullName = "Jane Doe";
    const String patientId = "PAT123";
    const String email = "jane.doe@email.com";

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.deepPurple.shade200,
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(fullName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('Patient ID: $patientId',
                      style: TextStyle(color: Colors.grey)),
                  Text(email,
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Notification Settings
          const Text("Notifications",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.notifications_active),
              title: const Text('Enable Notifications'),
              value: notifEnabled,
              onChanged: (val) {
                setState(() => notifEnabled = val);
                // TODO: Implement notification toggle logic
              },
            ),
          ),
          const SizedBox(height: 24),

          // Appearance Settings
          const Text("Appearance",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              value: isDarkMode,
              onChanged: (val) {
                setState(() => isDarkMode = val);
                // TODO: Hook into theme provider/BLoC or system theme
              },
            ),
          ),
          const SizedBox(height: 24),

          // Account Settings
          const Text("Account",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.lock_outline),
                  title: const Text('Change Password'),
                  onTap: () {
                    // TODO: Implement change password workflow
                  },
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.redAccent)),
                  onTap: () {
                    // TODO: Implement logout logic
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
