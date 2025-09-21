import 'dart:developer';

import 'package:beclean/core/mdoels/user.dart';
import 'package:beclean/core/services/api_service.dart';
import 'package:beclean/features/auth/models/new_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/user";

  User? _currentUser;

  User? get currentUser => _currentUser;
  String? get token => ApiService.token;
  String? get role => ApiService.role;

  Future<String?> register(NewUser user) async {
    try {
      final response = await ApiService.postRequest(
        "$_endpoint/register",
        body: user.toJson(),
      );
      if (response.statusCode < 300) {
        _currentUser = User.fromJson(response.data);
        await _setToken(response.data["token"], response.body["role"]);
        notifyListeners();
        return null;
      }
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future _setToken(String? token, String? role) async {
    ApiService.token = token;
    ApiService.role = role;
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      prefs.remove("TOKEN");
    } else {
      prefs.setString("TOKEN", token);
    }
    if (role == null) {
      prefs.remove("ROLE");
    } else {
      prefs.setString("ROLE", role);
    }
  }
}
