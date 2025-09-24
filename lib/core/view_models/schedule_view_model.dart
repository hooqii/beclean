import 'dart:convert';
import 'dart:developer';

import 'package:beclean/core/services/api_service.dart';
import 'package:beclean/features/collector/pickup/models/new_pickup.dart';
import 'package:beclean/features/user/pickup_schedule/models/pickup_schedule.dart';
import 'package:flutter/material.dart';

class ScheduleViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/jadwal_jemput";

  List<PickupSchedule> _pickupEvents = [];

  List<PickupSchedule> get pickupEvents => _pickupEvents;

  DateTime? get nextSchedule {
    final dates = _pickupEvents.map((event) => event.tanggal);
    final today = DateTime.now();
    final futureDates = dates.where((d) => d.isAfter(today)).toList();

    if (futureDates.isEmpty) return null;

    futureDates.sort((a, b) => a.compareTo(b));
    DateTime closestDate = futureDates.first;
    return closestDate;
  }

  List<PickupSchedule> get todaySchedule {
    return getEventsForDay(DateTime.now());
  }

  List<PickupSchedule> getEventsForDay(DateTime day) {
    return _pickupEvents.where((schedule) {
      return _isSameDay(schedule.tanggal, day);
    }).toList();
  }

  Future<String?> getSchedule() async {
    try {
      final response = await ApiService.getRequest(_endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        _pickupEvents = json.map((e) => PickupSchedule.fromJson(e)).toList();
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<String?> getScheduleCollector() async {
    try {
      final response = await ApiService.getRequest("$_endpoint?role=driver");
      if (response.statusCode < 300) {
        final json = response.data as List;
        _pickupEvents = json.map((e) => PickupSchedule.fromJson(e)).toList();
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get schedule: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<String?> processPickup(List<NewPickup> pickups) async {
    try {
      const endpoint = "${ApiService.baseUrl}/detail_jadwal/add_many";
      final pickupsMap = pickups.map((e) => e.toMap()).toList();
      final response = await ApiService.postRequest(
        endpoint,
        body: jsonEncode({"setoran": pickupsMap}),
      );
      if (response.statusCode < 300) {
        getScheduleCollector();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get schedule: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  void onLogout() {
    _pickupEvents = [];
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
