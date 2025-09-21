import 'dart:convert';

class NewUser {
  final String nik;
  final String email;
  final String nama;
  final String noHp;
  final String alamat;
  final String password;
  final double latitude;
  final double longitude;

  NewUser({
    required this.nik,
    required this.email,
    required this.nama,
    required this.noHp,
    required this.alamat,
    required this.password,
    required this.latitude,
    required this.longitude,
  });

  String toJson() {
    return jsonEncode({
      "nik": nik,
      "email": email,
      "nama": nama,
      "noHp": noHp,
      "alamat": alamat,
      "password": password,
      "latitude": latitude,
      "longitude": longitude,
    });
  }
}
