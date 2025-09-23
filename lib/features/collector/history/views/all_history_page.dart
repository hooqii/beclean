import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/features/user/pickup_schedule/models/pickup_schedule.dart';
import 'package:beclean/shared/widgets/collector_schedule_item.dart';
import 'package:flutter/material.dart';

class AllHistoryPage extends StatefulWidget {
  final List<PickupSchedule> events;
  const AllHistoryPage({super.key, required this.events});
  @override
  State<AllHistoryPage> createState() => _AllHistoryPageState();
}

class _AllHistoryPageState extends State<AllHistoryPage> {
  late List<PickupSchedule> filteredEvents;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    filteredEvents = widget.events;
    searchController.addListener(_filterEvents);
  }

  void _filterEvents() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredEvents = widget.events.where((event) {
        final name = event.nama.toString().toLowerCase();
        final date = event.tanggalString.toString().toLowerCase();
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
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
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
                        color: AppColors.primaryDark,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final item = filteredEvents[index];
                      return CollectorScheduleItem(item: item);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
