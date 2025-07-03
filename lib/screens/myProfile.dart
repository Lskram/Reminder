import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              'My Profile',
              style: GoogleFonts.kanit(
                textStyle: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Profile Picture
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!, width: 2),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Name
                Text(
                  'ratchanon',
                  style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Contact Info
                _buildInfoRow(
                  icon: Icons.email_outlined,
                  label: 'อีเมล',
                  value: 'six12345@email.com',
                  iconColor: Colors.green.shade400,
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  icon: Icons.phone_outlined,
                  label: 'เบอร์โทรศัพท์',
                  value: '081-234-5678',
                  iconColor: Colors.green.shade400,
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  icon: Icons.calendar_today_outlined,
                  label: 'วันเกิด',
                  value: '11 มีนาคม 2002',
                  iconColor: Colors.green.shade400,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'Log Out',
                  style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.kanit(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green.shade400,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(Icons.home, false, () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          _buildBottomNavItem(Icons.lightbulb_outline, false, () {
            // Navigate to tips page
          }),
          _buildBottomNavItem(Icons.directions_walk, false, () {
            // Navigate to exercise page
          }),
          _buildBottomNavItem(Icons.person_outline, true, () {
            // Already on profile page
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white70,
          size: 28,
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'แก้ไขโปรไฟล์',
            style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'คุณต้องการแก้ไขข้อมูลโปรไฟล์หรือไม่?',
            style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 16)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ยกเลิก',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add edit functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'ฟีเจอร์แก้ไขโปรไฟล์จะพัฒนาในอนาคต',
                      style: GoogleFonts.kanit(),
                    ),
                    backgroundColor: Colors.green.shade400,
                  ),
                );
              },
              child: Text(
                'แก้ไข',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(
                    color: Colors.green.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ออกจากระบบ',
            style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text(
            'คุณแน่ใจหรือไม่ที่จะออกจากระบบ?',
            style: GoogleFonts.kanit(textStyle: const TextStyle(fontSize: 16)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ยกเลิก',
                style: GoogleFonts.kanit(
                  textStyle: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add logout functionality here
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text(
                'ออกจากระบบ',
                style: GoogleFonts.kanit(
                  textStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
