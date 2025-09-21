import 'package:flutter/material.dart';

class UserPickupListPage extends StatefulWidget {
  const UserPickupListPage({super.key});

  @override
  State<UserPickupListPage> createState() => _UserPickupListPageState();
}

class _UserPickupListPageState extends State<UserPickupListPage> {
  final List<Map<String, dynamic>> pickupList = [
    {
      "name": "Steven Brenz",
      "address": "Jl. Merdeka No. 21",
      "date": "20 Agustus 2025",
      "time": "09:00",
    },
    {
      "name": "Anna Putri",
      "address": "Jl. Mawar No. 5",
      "date": "19 Agustus 2025",
      "time": "09:30",
    },
    {
      "name": "Budi Santoso",
      "address": "Jl. Kenanga No. 12",
      "date": "20 Agustus 2025",
      "time": "10:00",
    },
  ];

  List<Map<String, dynamic>> filteredList = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = pickupList; // awalnya semua data tampil
    searchController.addListener(_filterList);
  }

  void _filterList() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredList = pickupList.where((item) {
        final name = item["name"].toString().toLowerCase();
        final address = item["address"].toString().toLowerCase();
        return name.contains(query) || address.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cari nama atau alamat...",
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          // List hasil filter
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada data yang cocok.",
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final item = filteredList[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color.fromARGB(255, 23, 87, 14),
                            width: 0.8,
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
                              backgroundColor: const Color.fromARGB(
                                255,
                                23,
                                87,
                                14,
                              ),
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
          ),
        ],
      ),
    );
  }

  // 🗑 Dialog input berat (tetap sama dengan versi kamu sebelumnya)
  void _showInputWeightDialog(BuildContext context, String userName) {
    final TextEditingController totalWeightController = TextEditingController();
    final TextEditingController plastikController = TextEditingController();
    final TextEditingController kertasController = TextEditingController();
    final TextEditingController logamController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        bool isOrganikOnly = false;
        return StatefulBuilder(
          builder: (context, setState) {
            void calculateTotal() {
              double plastik = double.tryParse(plastikController.text) ?? 0;
              double kertas = double.tryParse(kertasController.text) ?? 0;
              double logam = double.tryParse(logamController.text) ?? 0;
              double total = plastik + kertas + logam;
              setState(() {
                totalWeightController.text = total > 0
                    ? total.toStringAsFixed(2)
                    : "";
              });
            }

            plastikController.addListener(calculateTotal);
            kertasController.addListener(calculateTotal);
            logamController.addListener(calculateTotal);

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
                width: 350,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Nama: $userName",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sampah organik semua",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Switch(
                            value: isOrganikOnly,
                            activeColor: const Color.fromARGB(255, 23, 87, 14),
                            onChanged: (value) {
                              setState(() {
                                isOrganikOnly = value;
                              });
                            },
                          ),
                        ],
                      ),
                      if (!isOrganikOnly) ...[
                        const Text(
                          "Detail Produk Daur Ulang:",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildProductField("Plastik (kg)", plastikController),
                        const SizedBox(height: 8),
                        _buildProductField("Kertas (kg)", kertasController),
                        const SizedBox(height: 8),
                        _buildProductField("Logam (kg)", logamController),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(20, 23, 87, 14),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color.fromARGB(255, 23, 87, 14),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Berat:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 23, 87, 14),
                                ),
                              ),
                              Text(
                                "${totalWeightController.text.isEmpty ? "0.00" : totalWeightController.text} kg",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    String total = totalWeightController.text;
                    String plastik = plastikController.text;
                    String kertas = kertasController.text;
                    String logam = logamController.text;
                    String message;
                    if (isOrganikOnly) {
                      message =
                          "Pickup untuk $userName berhasil disimpan (Organik semua, tanpa timbang)";
                    } else {
                      if (total.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Isi minimal 1 produk daur ulang dengan berat",
                            ),
                          ),
                        );
                        return;
                      }
                      message =
                          "Berat produk untuk $userName:\nPlastik: ${plastik.isEmpty ? '0' : plastik} kg\nKertas: ${kertas.isEmpty ? '0' : kertas} kg\nLogam: ${logam.isEmpty ? '0' : logam} kg\nTotal: $total kg";
                    }

                    Navigator.pop(context);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message)));
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
      },
    );
  }

  Widget _buildProductField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
    );
  }
}
