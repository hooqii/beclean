import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/features/user/pickup_schedule/models/pickup_schedule.dart';
import 'package:flutter/material.dart';

class CollectorScheduleItem extends StatelessWidget {
  const CollectorScheduleItem({super.key, required this.item});
  final PickupSchedule item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryDark.withAlpha(30),
        child: Icon(
          item.details != null ? Icons.history : Icons.calendar_month_outlined,
          color: AppColors.primaryDark,
        ),
      ),
      title: Text(
        item.user.nama,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
      ),
      subtitle: Text(
        "Tanggal: ${item.tanggalString}",
        style: const TextStyle(
          color: AppColors.primaryDark,
        ),
      ),
      trailing: Text(
        "${item.details?.berat ?? "-"} Kg",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
