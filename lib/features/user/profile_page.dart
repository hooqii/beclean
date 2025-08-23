import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/features/user/detail_account_user_page.dart';
import 'package:beclean/features/user/manage_password_user_page.dart';
import 'package:beclean/features/user/payment_account_page.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 50),

          /// Bagian Header (Profile Info)
          Container(
            padding: const EdgeInsets.only(left: 24, right: 40, top: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Steven Brenz',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'steven@email.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailAccountUserPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.chevron_right, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Card Menu
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Image.asset(
                    'assets/images/profile_1.png',
                    width: 38,
                    height: 38,
                  ),
                  text: "Detail Akun",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DetailAccountUserPage(),
                      ),
                    );
                  },
                ),
                // _divider(),
                _buildMenuItem(
                  icon: Image.asset(
                    'assets/images/lock.png',
                    width: 38,
                    height: 38,
                  ),
                  text: "Kelola Password",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManagePasswordUserPage(),
                      ),
                    );
                  },
                ),
                // _divider(),
                _buildMenuItem(
                  icon: Image.asset(
                    'assets/images/wallet.png',
                    width: 38,
                    height: 38,
                  ),
                  text: "Rekening Pembayaran",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentAccountPage(),
                      ),
                    );
                    // Arahkan ke ubah password
                  },
                ),
                const SizedBox(height: 20),

                /// Tombol Logout
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required Widget icon, // ganti dari IconData ke Widget
    required String text,
    Color textColor = const Color.fromARGB(255, 19, 75, 23),
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
      leading: icon, // langsung widget
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Widget _divider() {
  //   return Divider(
  //     color: Colors.grey.withOpacity(0.2),
  //     height: 1,
  //     thickness: 1,
  //     indent: 16,
  //     endIndent: 16,
  //   );
  // }
}
