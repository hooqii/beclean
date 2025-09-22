import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/utils/app_helpers.dart';
import 'package:beclean/features/user/product/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.read<ProductViewModel>().products;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Daftar Produk Daur Ulang',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final harga = AppHelpers.formatHarga(product.harga);

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryDark.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryDark.withOpacity(0.1),
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: SvgPicture.network(product.icon),
                ),
              ),
              title: Text(
                product.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                "$harga/kg",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
