import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:beclean/features/user/pickup_schedule/models/pickup_schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UserPickupSchedulePage extends StatefulWidget {
  const UserPickupSchedulePage({super.key, required this.title});
  final String? title;

  @override
  State<UserPickupSchedulePage> createState() => _UserPickupSchedulePageState();
}

class _UserPickupSchedulePageState extends State<UserPickupSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final getEventsForDay = context.read<ScheduleViewModel>().getEventsForDay;
    final events = getEventsForDay(_selectedDay ?? _focusedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? 'Jadwal Pickup',
          style: const TextStyle(color: AppColors.primaryDark),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
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
            eventLoader: getEventsForDay,
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
              titleTextStyle: TextStyle(color: AppColors.primaryDark),
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: AppColors.primaryDark,
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
                        color: AppColors.primaryDark,
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final schedule = events[index];
                      return _ScheduleItem(schedule: schedule);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({required this.schedule});
  final PickupSchedule schedule;

  void _openDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return _ScheduleDialog(schedule: schedule);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryDark.withAlpha(80),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: schedule.color.withAlpha(30),
          child: Icon(
            schedule.icon,
            color: schedule.color,
          ),
        ),
        title: Text(
          schedule.details?.tipe ?? "Penjemputan",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(schedule.tanggalString),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              schedule.details?.jumlahString ?? "-",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: schedule.color,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: schedule.color.withAlpha(60),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                schedule.status,
                style: TextStyle(
                  fontSize: 12,
                  color: schedule.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          if (schedule.details == null) return;
          _openDetails(context);
        },
      ),
    );
  }
}

class _ScheduleDialog extends StatelessWidget {
  const _ScheduleDialog({required this.schedule});
  final PickupSchedule schedule;

  @override
  Widget build(BuildContext context) {
    final details = schedule.details!;

    return Dialog(
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
                  schedule.icon,
                  color: schedule.color,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  details.tipe,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const Divider(height: 24, thickness: 1),
            Text(
              "Tanggal: ${schedule.tanggalString}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Berat: ${details.berat} Kg",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Saldo: ${details.jumlahString}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: schedule.color.withAlpha(60),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                schedule.status,
                style: TextStyle(
                  fontSize: 14,
                  color: schedule.color,
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
    );
  }
}
