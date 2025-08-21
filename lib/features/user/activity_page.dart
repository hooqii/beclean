import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {'date': '01-08-2025', 'desc': 'Tarik Tunai', 'amount': '-Rp 50.000'},
      {'date': '28-07-2025', 'desc': 'Setor Sampah', 'amount': '+Rp 20.000'},
    ];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          'Aktivitas Terkini',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 23, 87, 14),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color:  Color.fromARGB(255, 23, 87, 14)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final h = history[index];
          return Card(
            child: ListTile(
              title: Text(h['desc']!),
              subtitle: Text(h['date']!),
              trailing: Text(
                h['amount']!,
                style: TextStyle(
                  color: h['amount']!.startsWith('-')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
