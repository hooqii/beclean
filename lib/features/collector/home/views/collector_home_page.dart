import 'dart:ui';
import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';

class CollectorHomePage extends StatefulWidget {
  const CollectorHomePage({super.key});

  @override
  State<CollectorHomePage> createState() => _CollectorHomePageState();
}

class _CollectorHomePageState extends State<CollectorHomePage> {
  void _logout(BuildContext context) {
    context.read<AuthViewModel>().logout(context: context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<ScheduleViewModel>().getScheduleCollector();
  }

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
                        color: AppColors.primaryDark,
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
                            title: 'Daftar\nPenjemputan',
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
                        color: AppColors.primaryDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPickupList(),
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
    final nama = context.read<AuthViewModel>().currentCollector!.nama;

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
                backgroundColor: Color.fromARGB(255, 21, 56, 21),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Halo,',
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _logout(context),
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
    final nextDate = context.read<ScheduleViewModel>().nextSchedule;
    final nextDateString = nextDate != null
        ? DateFormat("dd MMMM yyyy - HH:mm").format(nextDate)
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.pickupScheduleCollector);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryDark.withOpacity(0.3),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kalender jadwal pickup',
                    style: TextStyle(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    nextDateString ?? "-",
                    style: const TextStyle(
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
              color: AppColors.primaryDark,
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
            color: AppColors.primaryDark.withOpacity(0.3),
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
                  color: AppColors.primaryDark,
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
  Widget _buildPickupList() {
    final schedules = context.read<ScheduleViewModel>().todaySchedule;

    if (schedules.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 24),
        child: Center(
          child: Text(
            "Tidak ada jadwal hari ini",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: schedules.map((schedule) {
        final hourString = DateFormat("HH:mm").format(schedule.tanggal);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: AppColors.primaryDark,
              width: 0.8,
            ),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.access_time,
              color: AppColors.primaryDark,
            ),
            title: Text(
              "Pukul - $hourString",
              style: const TextStyle(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
