import 'package:intl/intl.dart';

class AppHelpers {
  AppHelpers._();

  static String formatHarga(int harga) {
    String hargaString = NumberFormat("###,###,###").format(harga);
    hargaString = hargaString.replaceAll(",", ".");
    hargaString = "Rp $hargaString";
    return hargaString;
  }

  static String toTitleCase(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}
