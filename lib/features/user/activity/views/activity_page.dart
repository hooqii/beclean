import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/mutation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = context.read<MutationViewModel>().activities;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Aktivitas Terkini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 23, 87, 14),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryDark.withAlpha(80),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: activity.color.withAlpha(30),
                child: Icon(
                  activity.icon,
                  color: activity.color,
                ),
              ),
              title: Text(
                activity.judul,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(activity.tanggalString), // sekarang hanya tanggal
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    activity.jumlahString,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activity.jumlahColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: activity.color.withAlpha(60),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activity.status,
                      style: TextStyle(
                        fontSize: 12,
                        color: activity.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    insetPadding: const EdgeInsets.all(
                      16,
                    ), // jarak dari tepi layar
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                activity.icon,
                                color: activity.color,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                activity.judul,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, thickness: 1),
                          Text(
                            "Tanggal: ${activity.tanggalString}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: "Jumlah: "),
                                TextSpan(
                                  text: activity.jumlahString,
                                  style: TextStyle(color: activity.jumlahColor),
                                ),
                              ],
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: activity.color.withAlpha(60),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              activity.status,
                              style: TextStyle(
                                fontSize: 14,
                                color: activity.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Tutup",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
