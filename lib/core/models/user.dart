import 'package:beclean/core/models/payment_account.dart';

class User {
  final String id;
  final String nik;
  final String email;
  final String nama;
  final String noHp;
  final String alamat;
  final int saldo;
  final double latitude;
  final double longitude;
  final List<PaymentAccount> rekening;

  User({
    required this.id,
    required this.nik,
    required this.email,
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.saldo,
    required this.latitude,
    required this.longitude,
    required this.rekening,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final rekening = json["rekening"] as List;

    return User(
      id: json["id"],
      nik: json["nik"],
      email: json["email"],
      nama: json["nama"],
      noHp: json["noHp"],
      alamat: json["alamat"],
      saldo: json["saldo"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      rekening: rekening.map((e) => PaymentAccount.fromJson(e)).toList(),
    );
  }
}
