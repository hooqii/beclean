import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Data dummy history
  final List<Map<String, dynamic>> _history = const [
    {
      "type": "Penjemputan",
      "date": "21 Agustus 2025",
      "status": "Diproses",
      "weight": "5 Kg",
      "saldo": "+Rp 50.000"
    },
    {
      "type": "Penyetoran",
      "date": "20 Agustus 2025",
      "status": "Selesai",
      "weight": "3 Kg",
      "saldo": "+Rp 30.000"
    },
    {
      "type": "Penjemputan",
      "date": "18 Agustus 2025",
      "status": "Dibatalkan",
      "weight": "2 Kg",
      "saldo": "+Rp 0"
    },
    {
      "type": "Penjemputan",
      "date": "17 Agustus 2025",
      "status": "Selesai",
      "weight": "2 Kg",
      "saldo": "+Rp 20.000"
    },
  ];

  IconData _getIcon(String type) {
    if (type.contains("Penjemputan")) return Icons.local_shipping_outlined;
    if (type.contains("Penyetoran")) return Icons.recycling_outlined;
    return Icons.receipt_long_outlined;
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Selesai":
        return Colors.green;
      case "Diproses":
        return Colors.orange;
      case "Dibatalkan":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Riwayat Daur Ulang',
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
        itemCount: _history.length,
        itemBuilder: (context, index) {
          final item = _history[index];
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
                    _statusColor(item['status']!).withOpacity(0.1),
                child: Icon(
                  _getIcon(item['type']!),
                  color: _statusColor(item['status']!),
                ),
              ),
              title: Text(
                item['type']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['date']!),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item['saldo']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: item['saldo']!.startsWith('-')
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
                      color: _statusColor(item['status']!).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['status']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: _statusColor(item['status']!),
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
                    insetPadding: const EdgeInsets.all(16),
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
                                _getIcon(item['type']!),
                                color: _statusColor(item['status']!),
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                item['type']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, thickness: 1),
                          Text(
                            "Tanggal: ${item['date']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Berat: ${item['weight']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Saldo: ${item['saldo']}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  _statusColor(item['status']!).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: _statusColor(item['status']!),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 23, 87, 14),
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
