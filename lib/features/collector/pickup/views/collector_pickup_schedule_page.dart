import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:beclean/features/collector/history/views/all_history_page.dart';
import 'package:beclean/shared/widgets/collector_schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

/// 🔹 Helper class untuk dialog input berat sampah
class PickupDialogHelper {
  static void showInputWeightDialog(BuildContext context, String userName) {
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
                  color: AppColors.primaryDark,
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
                            activeColor: AppColors.primaryDark,
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
                              color: AppColors.primaryDark,
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
                                  color: AppColors.primaryDark,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
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

  static Widget _buildProductField(
    String label,
    TextEditingController controller,
  ) {
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

/// 🔹 Page Kalender Jadwal Pickup
class CollectorPickupSchedulePage extends StatefulWidget {
  const CollectorPickupSchedulePage({super.key});

  @override
  State<CollectorPickupSchedulePage> createState() =>
      _CollectorPickupSchedulePageState();
}

class _CollectorPickupSchedulePageState
    extends State<CollectorPickupSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final getEventsForDay = context.read<ScheduleViewModel>().getEventsForDay;
    final events = getEventsForDay(_selectedDay ?? _focusedDay);
    final preview = events.length > 3 ? events.sublist(0, 3) : events;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Pickup',
          style: TextStyle(color: AppColors.primaryDark),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryDark),
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
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: AppColors.primaryDark.withAlpha(100),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          const SizedBox(height: 16),
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
                    itemCount: preview.length,
                    itemBuilder: (context, index) {
                      final item = preview[index];
                      return CollectorScheduleItem(item: item);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AllHistoryPage(events: events);
                    },
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
                "Selengkapnya",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
