class PaymentMerchant {
  final String id;
  final String name;

  PaymentMerchant({
    required this.id,
    required this.name,
  });
}

final List<PaymentMerchant> banks = [
  PaymentMerchant(
    id: "MANDIRI_VIRTUAL_ACCOUNT",
    name: "Mandiri",
  ),
  PaymentMerchant(
    id: "BCA_VIRTUAL_ACCOUNT",
    name: "BCA",
  ),
  PaymentMerchant(
    id: "BRI_VIRTUAL_ACCOUNT",
    name: "BRI",
  ),
  PaymentMerchant(
    id: "BNI_VIRTUAL_ACCOUNT",
    name: "BNI",
  ),
];

final List<PaymentMerchant> wallets = [
  PaymentMerchant(
    id: "DANA",
    name: "Dana",
  ),
  PaymentMerchant(
    id: "GOPAY",
    name: "GoPay",
  ),
  PaymentMerchant(
    id: "SHOPEEPAY",
    name: "ShopeePay",
  ),
];
