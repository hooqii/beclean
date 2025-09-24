class NewPickup {
  final String scheduleId;
  final String userId;
  final String productId;
  final double weight;

  NewPickup({
    required this.scheduleId,
    required this.userId,
    required this.productId,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      "idJadwalJemput": scheduleId,
      "idUser": userId,
      "idProdukSampah": productId,
      "berat": weight,
    };
  }
}
