import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PickupSchedulePage extends StatefulWidget {
  const PickupSchedulePage({super.key});

  @override
  State<PickupSchedulePage> createState() => _PickupSchedulePageState();
}

class _PickupSchedulePageState extends State<PickupSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // contoh data jadwal pickup
  final Map<DateTime, List<String>> _pickupEvents = {
    DateTime.utc(2025, 8, 23): ['Pickup Pagi - 09:00', 'Pickup Sore - 16:00'],
    DateTime.utc(2025, 8, 25): ['Pickup Siang - 13:00'],
    DateTime.utc(2025, 8, 30): ['Pickup Malam - 20:00'],
  };

  List<String> _getEventsForDay(DateTime day) {
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
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: _getEventsForDay, // 👈 kasih event di tanggal yg ada
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: Text(
          //       'Pukul Jadwal Pickup Hari Ini',
          //       style: const TextStyle(
          //         color: Color.fromARGB(255, 23, 87, 14),
          //         fontWeight: FontWeight.bold,
          //         fontSize: 16,
          //       ),
          //     ),
          //   ),
          // ),
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
                      return Card(
                        color: Colors.white,
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
                            Icons.access_time,
                            color: Color.fromARGB(255, 23, 87, 14),
                          ),
                          title: Text(
                            events[index],
                            style: const TextStyle(
                              color: Color.fromARGB(255, 23, 87, 14),
                              fontWeight: FontWeight.w400,
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
