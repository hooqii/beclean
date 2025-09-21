import 'package:intl/intl.dart';

class AppHelpers {
  AppHelpers._();

  static String formatHarga(int harga) {
    String hargaString = NumberFormat("###,###,###").format(harga);
    hargaString = hargaString.replaceAll(",", ".");
    hargaString = "Rp $hargaString";
    return hargaString;
  }
}
