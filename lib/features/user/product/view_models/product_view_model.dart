import 'dart:developer';

import 'package:beclean/core/services/api_service.dart';
import 'package:beclean/features/user/product/models/product.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final _endpoint = "${ApiService.baseUrl}/produk_sampah";

  List<Product> _products = [];
  List<Product> get products => _products;

  Future<String?> getProducts() async {
    try {
      final response = await ApiService.getRequest(_endpoint);
      if (response.statusCode < 300) {
        final json = response.data as List;
        _products = json.map((e) => Product.fromJson(e)).toList();
        notifyListeners();
        return null;
      }
      throw Exception(response.message);
    } catch (e, stacktrace) {
      log("Failed to register: $e", stackTrace: stacktrace);
      return "Terjadi kesalahan";
    }
  }
}
