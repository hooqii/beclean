import 'package:flutter/material.dart';

class AllHistoryPage extends StatefulWidget {
  final Map<DateTime, List<Map<String, dynamic>>> historyEvents;
  const AllHistoryPage({super.key, required this.historyEvents});
  @override
  State<AllHistoryPage> createState() => _AllHistoryPageState();
}

class _AllHistoryPageState extends State<AllHistoryPage> {
  late List<Map<String, dynamic>> allEvents;
  late List<Map<String, dynamic>> filteredEvents;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Flatten Map ke List semua event
    allEvents = widget.historyEvents.entries
        .expand(
          (entry) => entry.value.map(
            (event) => {
              "name": event["name"],
              "date": event["date"],
              "weight": event["weight"],
            },
          ),
        )
        .toList();
    filteredEvents = allEvents;
    searchController.addListener(_filterEvents);
  }

  void _filterEvents() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredEvents = allEvents.where((event) {
        final name = event["name"].toString().toLowerCase();
        final date = event["date"].toString().toLowerCase();
        return name.contains(query) || date.contains(query);
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
          "Semua Riwayat",
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
                hintText: "Cari nama atau tanggal...",
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 28, // lebih proporsional lingkarannya
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
          // 🔹 List Riwayat
          Expanded(
            child: filteredEvents.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada riwayat yang cocok.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 87, 14),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final item = filteredEvents[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color.fromARGB(255, 23, 87, 14),
                            width: 0.8,
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                              255,
                              23,
                              87,
                              14,
                            ).withOpacity(0.1),
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
                            style: const TextStyle(
                              color: Color.fromARGB(255, 23, 87, 14),
                            ),
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
          ),
        ],
      ),
    );
  }
}
