import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PickupSchedulePageUser extends StatefulWidget {
  const PickupSchedulePageUser({super.key});

  @override
  State<PickupSchedulePageUser> createState() => _PickupSchedulePageUserState();
}

class _PickupSchedulePageUserState extends State<PickupSchedulePageUser> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // contoh data jadwal pickup per orang
  final Map<DateTime, List<Map<String, String>>> _pickupEvents = {
    DateTime.utc(2025, 9, 13): [
      {"name": "Steven Brenz", "time": "09:00"},
      {"name": "Anna Putri", "time": "16:00"},
    ],
    DateTime.utc(2025, 9, 15): [
      {"name": "Budi Santoso", "time": "13:00"},
    ],
    DateTime.utc(2025, 9, 17): [
      {"name": "Dewi Lestari", "time": "20:00"},
    ],
    DateTime.utc(2025, 9, 20): [
      {"name": "Steven Brenz", "time": "09:00"},
      {"name": "Andi Wijaya", "time": "20:00"},
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _pickupEvents[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Pickup',
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          const SizedBox(height: 16),

          // List Jadwal di bawah kalender
          Expanded(
            child: events.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada jadwal pickup untuk hari ini.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 23, 87, 14),
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final item = events[index];
                      return Card(
                        // color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 23, 87, 14),
                            width: 0.8,
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 23, 87, 14),
                          ),
                          title: Text(
                            item["name"] ?? "",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 23, 87, 14),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Jam Pickup: ${item["time"]}",
                            style: const TextStyle(
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
