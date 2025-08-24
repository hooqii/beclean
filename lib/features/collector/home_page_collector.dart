import 'dart:ui';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class CollectorHomePage extends StatelessWidget {
  const CollectorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Stack(
                children: [
                  Container(
                    height: 200,
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

              const SizedBox(height: 24),

              // CARD: Jadwal Hari Ini
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildScheduleCard(context),
              ),
              const SizedBox(height: 24),

              // MENU
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Menu Collector',
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
                              'assets/images/list.png',
                              width: 28,
                              height: 28,
                            ),
                            title: 'Daftar User',
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.userPickupList,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildServiceMenuItem(
                            icon: Image.asset(
                              'assets/images/history.png',
                              width: 28,
                              height: 28,
                            ),
                            title: 'Riwayat Penjemputan',
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.collectorHistory,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // LIST JADWAL PENJEMPUTAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jadwal pickup hari ini',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 87, 14),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPickupList([
                      'Pickup Pagi - 09:00',
                      'Pickup Sore - 16:00',
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER WIDGET
  Widget _buildHeader(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage('assets/images/person.png'),
                backgroundColor: Colors.green,
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo,', style: TextStyle(color: Colors.white70)),
                    Text(
                      'Collector Brandon',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                icon: const Icon(Icons.logout, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // CARD: Jadwal Hari Ini
  Widget _buildScheduleCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.pickupSchedule),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 23, 87, 14).withOpacity(0.3),
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
                    'Kalender jadwal pickup',
                    style: TextStyle(
                      color: Color.fromARGB(255, 23, 87, 14),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '10 Agustus 2025 - 08:00',
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
              size: 16,
              color: Color.fromARGB(255, 23, 87, 14),
            ),
          ],
        ),
      ),
    );
  }

  // MENU ITEM
  Widget _buildServiceMenuItem({
    required Widget icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 23, 87, 14).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: SizedBox(
          height: 80, // biar konsisten
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
    );
  }

  // LIST JADWAL PENJEMPUTAN
  Widget _buildPickupList(List<String> schedules) {
    return Column(
      children: schedules.map((schedule) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Color.fromARGB(255, 23, 87, 14),
              width: 0.8,
            ),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.access_time,
              color: Color.fromARGB(255, 23, 87, 14),
            ),
            title: Text(
              schedule,
              style: const TextStyle(
                color: Color.fromARGB(255, 23, 87, 14),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
