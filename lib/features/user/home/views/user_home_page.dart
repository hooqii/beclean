import 'package:beclean/core/utils/app_helpers.dart';
import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/features/user/home/views/home_carousel.dart';
import 'package:beclean/features/user/profile/views/detail_account_user_page.dart';
import 'package:beclean/features/user/withdraw/views/withdraw_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../../../routes/app_routes.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // biar lebih smooth
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Stack(
                  children: [
                    Container(
                      height: 238,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/nature.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(27),
                          bottomRight: Radius.circular(27),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 60, 16, 0),
                      child: _buildHeader(context),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // CAROUSEL
                const HomeCarousel(),

                // MENU
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildActiveScheduleCard(context),
                      const SizedBox(height: 24),
                      const Text(
                        'Layanan Lainnya',
                        style: TextStyle(
                          color: Color.fromARGB(255, 23, 87, 14),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildServiceMenuItem(
                              icon: Image.asset(
                                'assets/images/history.png',
                                width: 28,
                                height: 28,
                              ),
                              title: 'Riwayat Daur Ulang',
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.pickupAddress,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildServiceMenuItem(
                              icon: Image.asset(
                                'assets/images/list.png',
                                width: 28,
                                height: 28,
                              ),
                              title: 'Produk Daur Ulang',
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.productUser,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = context.watch<AuthViewModel>().currentUser!;
    final saldo = AppHelpers.formatHarga(user.saldo);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.only(
            top: 16,
            left: 18,
            right: 18,
            bottom: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailAccountUserPage(),
                        ),
                      ); // arahkan ke halaman profile
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 21, 56, 21),
                      backgroundImage: AssetImage('assets/images/person.png'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Halo,',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          user.nama,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 45,
                  //   height: 45,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(22.5),
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white.withOpacity(0.2),
                  //           shape: BoxShape.circle,
                  //           border: Border.all(
                  //             color: Colors.white.withOpacity(0.3),
                  //             width: 1,
                  //           ),
                  //         ),
                  //         child: Stack(
                  //           alignment: Alignment.center,
                  //           children: [
                  //             Image.asset(
                  //               'assets/images/notification.png',
                  //               width: 24,
                  //               height: 24,
                  //             ),
                  //             Positioned(
                  //               right: 8,
                  //               top: 8,
                  //               child: Container(
                  //                 padding: const EdgeInsets.all(2),
                  //                 decoration: const BoxDecoration(
                  //                   // color: Color.fromARGB(255, 239, 73, 22),
                  //                   shape: BoxShape.circle,
                  //                 ),
                  //                 constraints: const BoxConstraints(
                  //                   minWidth: 12,
                  //                   minHeight: 12,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Saldo Anda',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          saldo,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WithdrawPage(
                            accounts: [
                              {
                                "type": "Bank",
                                "provider": "BCA",
                                "number": "12345678",
                              },
                              {
                                "type": "E-Wallet",
                                "provider": "Dana",
                                "number": "0812345678",
                              },
                            ],
                            balance: 20000, // saldo user
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.35),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                      ),
                    ),
                    child: const Text('Cairkan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveScheduleCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.pickupScheduleUser);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(255, 25, 109, 3).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 8, 44, 8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/calendar.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jadwal pickup sampah',
                        style: TextStyle(
                          color: Color.fromARGB(255, 23, 87, 14),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pengangkutan: 10 Agustus 2025',
                        style: TextStyle(
                          color: Color.fromARGB(255, 83, 148, 14),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 23, 87, 14),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceMenuItem({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(255, 23, 87, 14).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 23, 87, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
