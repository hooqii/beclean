class Product {
  final String id;
  final String nama;
  final int harga;
  final String icon;

  Product({
    required this.id,
    required this.nama,
    required this.harga,
    required this.icon,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      nama: json["nama"],
      harga: json["harga"],
      icon: json["icon"],
    );
  }
}
