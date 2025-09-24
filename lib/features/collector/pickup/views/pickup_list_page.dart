import 'package:beclean/core/config/app_colors.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:beclean/features/collector/pickup/models/new_pickup.dart';
import 'package:beclean/features/user/pickup_schedule/models/pickup_schedule.dart';
import 'package:beclean/features/user/product/models/product.dart';
import 'package:beclean/features/user/product/view_models/product_view_model.dart';
import 'package:beclean/shared/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPickupListPage extends StatefulWidget {
  const UserPickupListPage({super.key});

  @override
  State<UserPickupListPage> createState() => _UserPickupListPageState();
}

class _UserPickupListPageState extends State<UserPickupListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";

  void _filterList() {
    String query = _searchController.text.toLowerCase();
    setState(() => _query = query);
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pickupList = context.watch<ScheduleViewModel>().todaySchedule;

    final filteredList = pickupList.where((item) {
      if (_query.isEmpty) return true;
      final name = item.user.nama.toString().toLowerCase();
      final address = item.user.alamat.toString().toLowerCase();
      return name.contains(_query) || address.contains(_query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Daftar Penjemputan",
          style: TextStyle(
            color: AppColors.primaryDark,
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
              controller: _searchController,
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
            child: filteredList.isEmpty || pickupList.isEmpty
                ? Center(
                    child: Text(
                      pickupList.isEmpty
                          ? "Tidak ada jadwal hari ini."
                          : "Tidak ada data yang cocok.",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
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
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primaryDark,
                            width: 0.8,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primaryDark.withAlpha(
                              30,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          title: Text(
                            item.user.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            "${item.user.alamat}\nJam: ${item.hoursString}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          trailing: _buildTraililng(item),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _processItem(PickupSchedule schedule) {
    showDialog(
      context: context,
      builder: (context) => _InputSampahDialog(schedule: schedule),
    );
  }

  Widget _buildTraililng(PickupSchedule schedule) {
    if (schedule.details == null) {
      return ElevatedButton(
        onPressed: () {
          _processItem(schedule);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
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
      );
    }

    return const Text(
      "Selesai",
      style: TextStyle(color: AppColors.primaryDark),
    );
  }
}

class _InputSampahDialog extends StatefulWidget {
  const _InputSampahDialog({required this.schedule});
  final PickupSchedule schedule;

  @override
  State<_InputSampahDialog> createState() => _InputSampahDialogState();
}

class _InputSampahDialogState extends State<_InputSampahDialog> {
  final List<Product> _selectedProducts = [];
  final List<TextEditingController> _controllers = [];

  bool _loading = false;
  String? _error;

  List<Product> get _products {
    final allProducts = context.read<ProductViewModel>().products;
    final productIds = _selectedProducts.map((e) => e.id);
    return allProducts.where((product) {
      return !productIds.contains(product.id);
    }).toList();
  }

  void _onChange(int index, Product product) {
    setState(() => _selectedProducts[index] = product);
  }

  void _remove(int index) {
    setState(() {
      _selectedProducts.removeAt(index);
      _controllers.removeAt(index);
    });
  }

  void _add() {
    if (_products.isEmpty) return;
    setState(() {
      _selectedProducts.add(_products[0]);
      _controllers.add(TextEditingController());
    });
  }

  void _processPickup() async {
    if (_loading) return;
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        setState(() => _error = "Berat tidak boleh kosong");
        return;
      }
    }

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final scheduleVM = context.read<ScheduleViewModel>();

    final schedule = widget.schedule;
    final pickups = List.generate(_selectedProducts.length, (index) {
      final product = _selectedProducts[index];
      final weight = double.parse(_controllers[index].text);

      return NewPickup(
        scheduleId: schedule.scheduleId!,
        userId: schedule.user.id,
        productId: product.id,
        weight: weight,
      );
    });

    setState(() {
      _loading = true;
      _error = null;
    });

    final error = await scheduleVM.processPickup(
      pickups,
    );

    if (error == null) {
      final weight = pickups.fold(0.0, (v, e) => v + e.weight);
      final message =
          "Penjemputan sampah untuk ${schedule.user.nama} berhasil diambil dengan total berat ${weight}Kg";
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.primary,
        ),
      );
      navigator.pop();
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Input Berat Sampah",
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text("Nama: ${widget.schedule.user.nama}"),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  "Sudah termasuk sampah organik",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Center(child: ErrorView(error: _error)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedProducts.length,
                itemBuilder: (context, index) {
                  final product = _selectedProducts[index];
                  final controller = _controllers[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: InkWell(
                      onTap: () => _remove(index),
                      borderRadius: BorderRadius.circular(999),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: DropdownButton(
                            padding: EdgeInsets.zero,
                            value: product,
                            onChanged: (value) => _onChange(index, value!),
                            items: _buildDropdownItems(product),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "(Kg)",
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Center(
                child: TextButton(
                  onPressed: _add,
                  child: const Text(
                    "+ Tambah",
                    style: TextStyle(color: AppColors.primaryDark),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Batal"),
                  ),
                  ElevatedButton(
                    onPressed: _processPickup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _loading
                          ? AppColors.primaryDark.withAlpha(125)
                          : AppColors.primaryDark,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _buildDropdownItems(Product product) {
    final products = [product, ..._products];
    return products.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text(
          item.nama,
          style: const TextStyle(fontSize: 14),
        ),
      );
    }).toList();
  }
}
