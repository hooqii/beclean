import 'package:flutter/material.dart';

class CollectorHistoryPage extends StatelessWidget {
  const CollectorHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> history = [
      {"name": "Steven Brenz", "date": "20 Agustus 2025", "weight": 5.2},
      {"name": "Anna Putri", "date": "19 Agustus 2025", "weight": 3.7},
      {"name": "Budi Santoso", "date": "18 Agustus 2025", "weight": 4.1},
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Riwayat Penjemputan",
          style: TextStyle(
            color: Color.fromARGB(255, 23, 87, 14),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 23, 87, 14),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
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
                child: const Icon(
                  Icons.history,
                  color: Color.fromARGB(255, 23, 87, 14),
                ),
              ),
              title: Text(
                item["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 87, 14),
                ),
              ),
              subtitle: Text(
                "Tanggal: ${item["date"]}",
                style: const TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
              ),
              trailing: Text(
                "${item["weight"]} kg",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 23, 87, 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
