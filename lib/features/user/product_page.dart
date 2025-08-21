import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Botol Plastik', 'price': 'Rp 2.000/kg'},
      {'name': 'Kertas', 'price': 'Rp 1.500/kg'},
      {'name': 'Kaleng', 'price': 'Rp 3.000/kg'},
    ];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Daftar Produk Daur Ulang',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color:  Colors.black)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            child: ListTile(
              title: Text(p['name']!),
              subtitle: Text(p['price']!),
            ),
          );
        },
      ),
    );
  }
}
