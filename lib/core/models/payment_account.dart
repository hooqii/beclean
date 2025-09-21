import 'package:beclean/features/user/profile/models/payment_merchant.dart';

class PaymentAccount {
  final String id;
  final PaymentMerchant merchant;
  final String nomor;

  PaymentAccount({
    required this.id,
    required this.merchant,
    required this.nomor,
  });

  String get type {
    for (var bank in banks) {
      if (merchant.id == bank.id) {
        return "Bank";
      }
    }
    return "E-Wallet";
  }

  factory PaymentAccount.fromJson(Map<String, dynamic> json) {
    final merchants = [...banks, ...wallets];
    final merchant = merchants.firstWhere((e) => e.id == json["merchant"]);

    return PaymentAccount(
      id: json["id"],
      merchant: merchant,
      nomor: json["nomor"],
    );
  }
}
