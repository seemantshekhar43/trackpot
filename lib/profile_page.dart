import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color accentGreen = Color(0xFFCFFFCF);

  // Purple theme (Luxury and creativity)
  static const Color primaryPurple = Color(0xFF6A1B9A);
  static const Color accentPurple = Color(0xFFE1BEE7);

  // Teal theme (Modern and calming)
  static const Color primaryTeal = Color(0xFF009688);
  static const Color accentTeal = Color(0xFFB2DFDB);

  // Orange theme (Energetic and friendly)
  static const Color primaryOrange = Color(0xFFFF5722);
  static const Color accentOrange = Color(0xFFFFCCBC);

  // Indigo theme (Professional and stable)
  static const Color primaryIndigo = Color(0xFF3F51B5);
  static const Color accentIndigo = Color(0xFFC5CAE9);

  // Amber theme (Warm and inviting)
  static const Color primaryAmber = Color(0xFFFFA000);
  static const Color accentAmber = Color(0xFFFFECB3);

  final Color primaryColor = Color(0xFF4CAF50); // Rich green
  final Color accentColor = Color(0xFFCFFFCF); // Light minty green
  final Color backgroundColor = Color(0xFFF5F5F5); // Light grey background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            _buildProfileSection(),
            _buildEarnMoneySection(),
            _buildSettingsSection('Account settings', [
              SettingsItem(icon: Icons.person_outline, title: 'Personal information'),
              SettingsItem(icon: Icons.payment, title: 'Payments and payouts'),
              SettingsItem(icon: Icons.translate, title: 'Translation'),
              SettingsItem(icon: Icons.notifications_none, title: 'Notifications'),
              SettingsItem(icon: Icons.lock_outline, title: 'Privacy and sharing'),
            ]),
            _buildSettingsSection('Hosting', [
              SettingsItem(icon: Icons.home_outlined, title: 'List your space'),
            ]),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: accentColor,
          child: Icon(Icons.person, color: primaryColor),
        ),
        title: Text('Matt', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Show profile', style: TextStyle(color: Colors.grey[600])),
        trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
      ),
    );
  }

  Widget _buildEarnMoneySection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.monetization_on_outlined, color: primaryColor),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Earn money from your extra space',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                Text('Learn more',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: primaryColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<SettingsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
          child: Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: items.map((item) => ListTile(
              leading: Icon(item.icon, color: primaryColor),
              title: Text(item.title),
              trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlists'),
        BottomNavigationBarItem(icon: Icon(Icons.trip_origin), label: 'Trips'),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Inbox'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      currentIndex: 4, // Profile tab is selected
    );
  }
}

class SettingsItem {
  final IconData icon;
  final String title;

  SettingsItem({required this.icon, required this.title});
}