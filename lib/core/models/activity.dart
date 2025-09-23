import 'package:beclean/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Activity {
  final String id;
  final String status;
  final String judul;
  final int jumlah;
  final DateTime tanggal;

  Activity({
    required this.id,
    required this.status,
    required this.judul,
    required this.jumlah,
    required this.tanggal,
  });

  Color get color {
    switch (status) {
      case "Proses":
        return Colors.orange;
      case "Selesai":
        return Colors.green;
      case "Gagal":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get jumlahColor {
    if (jumlah > 0) return Colors.green;
    return Colors.red;
  }

  IconData get icon {
    if (judul.contains("Tarik")) return Icons.account_balance_wallet_outlined;
    if (judul.contains("Setor")) return Icons.recycling_outlined;
    return Icons.calendar_month_outlined;
  }

  String get tanggalString {
    final formatter = DateFormat("dd-MM-yyyy");
    return formatter.format(tanggal);
  }

  String get jumlahString {
    return AppHelpers.formatHarga(jumlah);
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    final status = AppHelpers.toTitleCase(json["status"]);

    return Activity(
      id: json["id"],
      status: status,
      judul: json["judul"],
      jumlah: json["jumlah"],
      tanggal: DateTime.parse(json["createdAt"]),
    );
  }
}
