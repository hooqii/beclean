import 'package:flutter/material.dart';

class UserPickupListPage extends StatelessWidget {
  const UserPickupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pickupList = [
      {
        "name": "Steven Brenz",
        "address": "Jl. Merdeka No. 21",
        "time": "09:00",
      },
      {"name": "Anna Putri", "address": "Jl. Mawar No. 5", "time": "09:30"},
      {
        "name": "Budi Santoso",
        "address": "Jl. Kenanga No. 12",
        "time": "10:00",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Daftar Penjemputan",
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
        itemCount: pickupList.length,
        itemBuilder: (context, index) {
          final item = pickupList[index];
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
                backgroundColor: const Color.fromARGB(
                  255,
                  23,
                  87,
                  14,
                ).withOpacity(0.1),
                child: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 23, 87, 14),
                ),
              ),
              title: Text(
                item["name"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                "${item["address"]}\nJam: ${item["time"]}",
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _showInputWeightDialog(context, item["name"]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 23, 87, 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  "Proses",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showInputWeightDialog(BuildContext context, String userName) {
    final TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Input Berat Sampah",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 23, 87, 14),
            ),
          ),
          content: SizedBox(
            width: 300, // 🔥 atur width sesuai kebutuhan
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama: $userName",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "contoh: 5.3",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.scale),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                String weight = weightController.text;
                if (weight.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Berat tidak boleh kosong")),
                  );
                  return;
                }
                Navigator.pop(context); // tutup popup
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Berat $weight kg untuk $userName berhasil disimpan",
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 23, 87, 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
