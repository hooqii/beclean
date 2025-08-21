import 'package:flutter/material.dart';
import '../../core/widgets/custom_button.dart';

class PickupPage extends StatelessWidget {
  const PickupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Pickup Sampah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Alamat: Jl. Mawar No. 10'),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Berat Sampah (kg)'),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Selesai Pickup',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pickup berhasil dicatat')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
