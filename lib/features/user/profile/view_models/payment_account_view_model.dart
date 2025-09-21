import 'dart:convert';
import 'dart:developer';

import 'package:beclean/core/services/api_service.dart';
import 'package:flutter/material.dart';

class PaymentAccountViewModel extends ChangeNotifier {
  final String _endpoint = "${ApiService.baseUrl}/rekening";

  Future<String?> addAccount(String merchant, String nomor) async {
    try {
      final response = await ApiService.postRequest(
        "$_endpoint/add",
        body: jsonEncode({
          "merchant": merchant,
          "nomor": nomor,
        }),
      );
      if (response.statusCode < 300) return null;
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<String?> removeAccount(String id) async {
    try {
      final response = await ApiService.deleteRequest("$_endpoint/remove/$id");
      if (response.statusCode < 300) return null;
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }
}
