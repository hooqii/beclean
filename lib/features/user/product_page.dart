import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {'name': 'Botol Plastik', 'price': 'Rp 2.000/kg', 'type': 'plastik'},
      {'name': 'Kertas', 'price': 'Rp 1.500/kg', 'type': 'kertas'},
      {'name': 'Kaleng', 'price': 'Rp 3.000/kg', 'type': 'kaleng'},
    ];

    IconData _getIcon(String type) {
      switch (type) {
        case "plastik":
          return Icons.local_drink_outlined;
        case "kertas":
          return Icons.description_outlined;
        case "kaleng":
          return Icons.coffee_outlined;
        default:
          return Icons.recycling_outlined;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Daftar Produk Daur Ulang',
          style: TextStyle(
            color: Color.fromARGB(255, 23, 87, 14),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color.fromARGB(255, 23, 87, 14).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor:
                    const Color.fromARGB(255, 23, 87, 14).withOpacity(0.1),
                child: Icon(
                  _getIcon(p['type']!),
                  color: const Color.fromARGB(255, 23, 87, 14),
                ),
              ),
              title: Text(
                p['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                p['price']!,
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
