import 'package:beclean/features/collector/all_history_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CollectorHistoryPage extends StatefulWidget {
  const CollectorHistoryPage({super.key});

  @override
  State<CollectorHistoryPage> createState() => _CollectorHistoryPageState();
}

class _CollectorHistoryPageState extends State<CollectorHistoryPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Map<DateTime, List<Map<String, dynamic>>> _historyEvents = {
    DateTime.utc(2025, 9, 3): [
      {"name": "Steven Brenz", "date": "20 Agustus 2025", "weight": 5.2},
    ],
    DateTime.utc(2025, 9, 6): [
      {"name": "Anna Putri", "date": "19 Agustus 2025", "weight": 3.7},
    ],
    DateTime.utc(2025, 9, 7): [
      {"name": "Budi Santoso", "date": "18 Agustus 2025", "weight": 4.1},
    ],
  };

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _historyEvents[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);
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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
      ),
      body: Column(
        children: [
          // Kalender
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() => _calendarFormat = format);
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color.fromARGB(255, 23, 87, 14),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color.fromARGB(100, 23, 87, 14),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          const SizedBox(height: 12),
          // List sesuai tanggal
          Expanded(
            child: events.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada riwayat penjemputan di hari ini.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 87, 14),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final item = events[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        // padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color.fromARGB(255, 23, 87, 14),
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
          // Tombol Lihat Semua
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AllHistoryPage(historyEvents: _historyEvents),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 23, 87, 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              icon: const Icon(Icons.list, color: Colors.white),
              label: const Text(
                "Lihat Semua Riwayat",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
