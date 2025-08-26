import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const ProfileScreen({Key? key, required this.isDark, required this.toggleTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile.jpg'), // Replace with actual image
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Claire Cooper',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('claire.cooper@mail.com', style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // General Section
            Align(
              alignment: Alignment.centerLeft,
              child: Text('General', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            SizedBox(height: 12),
            _buildMenuItem(context, Icons.receipt_long_outlined, 'Transaction'),
            _buildMenuItem(context, Icons.favorite_border, 'Wishlist'),
            _buildMenuItem(context, Icons.location_on_outlined, 'Saved Address'),
            _buildMenuItem(context, Icons.payment_outlined, 'Payment Methods'),
            _buildMenuItem(context, Icons.notifications_none, 'Notification'),
            _buildMenuItem(context, Icons.lock_outline, 'Security'),

            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Help', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            SizedBox(height: 12),
            _buildMenuItem(context, Icons.help_outline, 'Support'),
            _buildMenuItem(context, Icons.info_outline, 'About'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            // Navigate to cart
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'My Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined), label: 'My Account'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Handle menu tap
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary),
              SizedBox(width: 12),
              Expanded(child: Text(title, style: TextStyle(fontSize: 16))),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}