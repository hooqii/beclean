import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';

class PickupAddress extends StatefulWidget {
  const PickupAddress({super.key});

  @override
  State<PickupAddress> createState() => _PickupAddressState();
}

class _PickupAddressState extends State<PickupAddress> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDusun;
  String? _selectedKampung;
  String? _selectedKecamatan;
  final _addressController = TextEditingController();

  final _dusunList = ['Dusun A', 'Dusun B', 'Dusun C'];
  final _kampungList = ['Kampung X', 'Kampung Y', 'Kampung Z'];
  final _kecamatanList = ['Kecamatan 1', 'Kecamatan 2', 'Kecamatan 3'];

  Future<void> _getCurrentLocation() async {
    setState(() {
      _addressController.text =
          "Lokasi otomatis: -7.250445, 112.768845"; // Contoh koordinat
    });
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Request pickup terkirim')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Alamat Penjemputan',
          style: TextStyle(color: Color.fromARGB(255, 23, 87, 14)),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 23, 87, 14)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  _buildGlassDropdown(
                    hintText: "Pilih Kecamatan Yang Tersedia",
                    value: _selectedKecamatan,
                    items: _kecamatanList,
                    onChanged: (val) =>
                        setState(() => _selectedKecamatan = val),
                    validator: (val) => val == null ? 'Pilih kecamatan' : null,
                    icon: Icons.map_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildGlassDropdown(
                    hintText: "Pilih Kampung Yang Tersedia",
                    value: _selectedKampung,
                    items: _kampungList,
                    onChanged: (val) => setState(() => _selectedKampung = val),
                    validator: (val) => val == null ? 'Pilih kampung' : null,
                    icon: Icons.location_city_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildGlassDropdown(
                    hintText: "Pilih Dusun Yang Tersedia",
                    value: _selectedDusun,
                    items: _dusunList,
                    onChanged: (val) => setState(() => _selectedDusun = val),
                    validator: (val) => val == null ? 'Pilih dusun' : null,
                    icon: Icons.home_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildGlassTextField(
                    controller: _addressController,
                    hintText: 'Alamat Lengkap',
                    icon: Icons.location_on_outlined,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.my_location,
                        color: Color(0xFF164A2B),
                      ),
                      onPressed: _getCurrentLocation,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'Atur Alamat Penjemputan',
                    onPressed: _submitRequest,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassDropdown({
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required FormFieldValidator<String?> validator,
    required IconData icon,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(
              hintText,
              style: const TextStyle(color: Color(0xFF164A2B)),
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: const TextStyle(color: Color(0xFF164A2B)),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            validator: validator,
            iconEnabledColor: Color.fromARGB(255, 23, 87, 14),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Color.fromARGB(255, 23, 87, 14)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            dropdownColor: Colors.white.withOpacity(0.9),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: Colors.white.withOpacity(0.2),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Color(0xFF164A2B)),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xFF164A2B)),
              prefixIcon: Icon(icon, color: const Color(0xFF164A2B)),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
            ),
            validator: (val) =>
                val == null || val.isEmpty ? 'Harus diisi' : null,
          ),
        ),
      ),
    );
  }
}
