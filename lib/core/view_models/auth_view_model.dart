import 'dart:convert';
import 'dart:developer';

import 'package:beclean/core/models/collector.dart';
import 'package:beclean/core/models/user.dart';
import 'package:beclean/core/services/api_service.dart';
import 'package:beclean/features/auth/models/new_user.dart';
import 'package:beclean/features/user/profile/models/account_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/user";

  User? _currentUser;
  Collector? _currentCollector;

  User? get currentUser => _currentUser;
  Collector? get currentCollector => _currentCollector;
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

  Future<String?> login(String email, String password) async {
    try {
      final response = await ApiService.postRequest(
        "$_endpoint/login",
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode < 300) {
        await _setToken(response.data["token"], response.body["role"]);
        if (role == "user") {
          _currentUser = User.fromJson(response.data);
        } else {
          _currentCollector = Collector.fromJson(response.data);
        }
        notifyListeners();
        return null;
      }
      return response.message;
    } catch (e, stacktrace) {
      log("Failed to login: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }

  Future<bool> logout() async {
    try {
      final response = ApiService.deleteRequest("$_endpoint/logout");
      await _setToken(null, null);
      notifyListeners();
      return (await response).statusCode < 300;
    } catch (e, stacktrace) {
      log("Failed to logout: $e", stackTrace: stacktrace);
      return false;
    }
  }

  Future<User> getProfile() async {
    try {
      final response = await ApiService.getRequest("$_endpoint/profile");
      if (response.statusCode < 300) {
        final user = User.fromJson(response.data);
        _currentUser = user;
        notifyListeners();
        return user;
      }
      await logout();
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get profile: $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<Collector> getCollectorProfile() async {
    try {
      const endpoint = "${ApiService.baseUrl}/driver/profile";
      final response = await ApiService.getRequest(endpoint);
      if (response.statusCode < 300) {
        final collector = Collector.fromJson(response.data);
        _currentCollector = collector;
        notifyListeners();
        return collector;
      }
      await logout();
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to get profile: $e", stackTrace: stacktrace);
      rethrow;
    }
  }

  Future<bool> loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      ApiService.token = prefs.getString("TOKEN");
      ApiService.role = prefs.getString("ROLE");
      log("TOKEN: $token");
      log("ROLE: $role");
      notifyListeners();

      if (token == null || role == null) return true;
      if (role == "user") {
        await getProfile();
      } else {
        await getCollectorProfile();
      }
      return true;
    } catch (e, stacktrace) {
      log("Failed to load profile: $e", stackTrace: stacktrace);
      return false;
    }
  }

  Future<String?> updateProfil(AccountDetails account) async {
    try {
      final response = await ApiService.putRequest(
        "$_endpoint/profile",
        body: account.toJson(),
      );
      if (response.statusCode < 300) {
        final json = response.data;
        _currentUser = User.fromJson(json);
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to update profile: $e", stackTrace: stacktrace);
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
