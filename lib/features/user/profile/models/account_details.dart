import 'dart:convert';

class AccountDetails {
  final String nik;
  final String nama;
  final String email;
  final String noHp;
  final String alamat;

  AccountDetails({
    required this.nik,
    required this.nama,
    required this.email,
    required this.noHp,
    required this.alamat,
  });

  String toJson() {
    return jsonEncode({
      "nik": nik,
      "nama": nama,
      "email": email,
      "noHp": noHp,
      "alamat": alamat,
    });
  }
}
