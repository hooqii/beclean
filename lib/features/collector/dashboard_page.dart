import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../core/widgets/custom_card.dart';

class DashboardCollectorPage extends StatelessWidget {
  const DashboardCollectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {'name': 'User A', 'address': 'Jl. Mawar No. 10'},
      {'name': 'User B', 'address': 'Jl. Melati No. 5'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Petugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final t = tasks[index];
            return CustomCard(
              title: t['name']!,
              subtitle: t['address']!,
              onTap: () => Navigator.pushNamed(context, AppRoutes.pickupCollector),
            );
          },
        ),
      ),
    );
  }
}
