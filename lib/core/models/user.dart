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
  });

  factory User.fromJson(Map<String, dynamic> json) {
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
    );
  }
}
