class Collector {
  final String id;
  final String email;
  final String nama;
  final String noHp;

  Collector({
    required this.id,
    required this.email,
    required this.nama,
    required this.noHp,
  });

  factory Collector.fromJson(Map<String, dynamic> json) {
    return Collector(
      id: json["id"],
      email: json["email"],
      nama: json["nama"],
      noHp: json["noHp"],
    );
  }
}
