import 'dart:convert';
import 'dart:developer';

import 'package:beclean/core/services/api_service.dart';
import 'package:beclean/core/models/activity.dart';
import 'package:flutter/material.dart';

class MutationViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/mutasi";

  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  Future<String?> getActivities() async {
    try {
      final response = await ApiService.getRequest(_endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        _activities = json.map((e) => Activity.fromJson(e)).toList();
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<String?> withdraw(String rekening, int jumlah) async {
    try {
      final response = await ApiService.putRequest(
        "$_endpoint/withdraw",
        body: jsonEncode({
          "jumlah": jumlah,
          "rekeningId": rekening,
        }),
      );
      if (response.statusCode < 300) return null;
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  void onLogout() {
    _activities = [];
  }
}
