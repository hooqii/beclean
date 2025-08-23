import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      {
        'date': '01-08-2025',
        'desc': 'Tarik Tunai',
        'amount': '-Rp 50.000',
        'status': 'Proses',
      },
      {
        'date': '28-07-2025',
        'desc': 'Setor Sampah',
        'amount': '+Rp 20.000',
        'status': 'Selesai',
      },
      {
        'date': '25-07-2025',
        'desc': 'Tarik Tunai',
        'amount': '-Rp 100.000',
        'status': 'Selesai',
      },
      {
        'date': '20-07-2025',
        'desc': 'Setor Sampah',
        'amount': '+Rp 15.000',
        'status': 'Selesai',
      },
    ];

    IconData _getIcon(String desc) {
      if (desc.contains("Tarik")) return Icons.account_balance_wallet_outlined;
      if (desc.contains("Setor")) return Icons.recycling_outlined;
      return Icons.receipt_long_outlined;
    }

    Color _getStatusColor(String status) {
      switch (status) {
        case "Proses":
          return Colors.orange;
        case "Selesai":
          return Colors.green;
        case "Gagal":
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(
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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: history.length,
        itemBuilder: (context, index) {
          final h = history[index];
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
                backgroundColor: _getStatusColor(h['status']!).withOpacity(0.1),
                child: Icon(
                  _getIcon(h['desc']!),
                  color: _getStatusColor(h['status']!),
                ),
              ),
              title: Text(
                h['desc']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(h['date']!), // sekarang hanya tanggal
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    h['amount']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: h['amount']!.startsWith('-')
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(h['status']!).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      h['status']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(h['status']!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    insetPadding: const EdgeInsets.all(
                      16,
                    ), // jarak dari tepi layar
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                _getIcon(h['desc']!),
                                color: _getStatusColor(h['status']!),
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                h['desc']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, thickness: 1),
                          Text(
                            "Tanggal: ${h['date']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Jumlah: ${h['amount']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                h['status']!,
                              ).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              h['status']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: _getStatusColor(h['status']!),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  23,
                                  87,
                                  14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Tutup",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
