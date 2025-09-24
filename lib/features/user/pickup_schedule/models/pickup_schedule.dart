import 'package:beclean/core/utils/app_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickupSchedule {
  final DateTime tanggal;
  final ScheduleUser user;
  final ScheduleDetail? details;
  final String? scheduleId;

  PickupSchedule({
    required this.tanggal,
    required this.user,
    required this.details,
    required this.scheduleId,
  });

  IconData get icon {
    if (details == null) return Icons.local_shipping_outlined;
    if (details!.tipe.contains("Penjemputan")) {
      return Icons.local_shipping_outlined;
    }
    if (details!.tipe.contains("Penyetoran")) return Icons.recycling_outlined;
    return Icons.receipt_long_outlined;
  }

  String get status {
    if (details == null) return "Dijadwalkan";
    return "Selesai";
  }

  Color get color {
    if (details == null) return Colors.grey;
    return Colors.green;
  }

  String get tanggalString {
    final formatter = DateFormat("dd MMMM yyyy");
    return formatter.format(tanggal);
  }

  String get hoursString {
    final formatter = DateFormat("HH:mm");
    return formatter.format(tanggal);
  }

  factory PickupSchedule.fromJson(Map<String, dynamic> json) {
    final details = json["details"];

    return PickupSchedule(
      tanggal: DateTime.parse(json["tanggal"]),
      user: ScheduleUser.fromJson(json["user"]),
      scheduleId: json["idJadwal"],
      details: details != null ? ScheduleDetail.fromJson(details) : null,
    );
  }
}

class ScheduleDetail {
  final String tipe;
  final int jumlah;
  final double berat;

  ScheduleDetail({
    required this.tipe,
    required this.jumlah,
    required this.berat,
  });

  String get jumlahString {
    return AppHelpers.formatHarga(jumlah);
  }

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      tipe: json["tipe"],
      jumlah: json["jumlah"],
      berat: double.parse(json["berat"].toString()),
    );
  }
}

class ScheduleUser {
  final String id;
  final String nama;
  final String alamat;

  ScheduleUser({
    required this.id,
    required this.nama,
    required this.alamat,
  });

  factory ScheduleUser.fromJson(Map<String, dynamic> json) {
    return ScheduleUser(
      id: json["id"],
      nama: json["nama"],
      alamat: json["alamat"],
    );
  }
}
