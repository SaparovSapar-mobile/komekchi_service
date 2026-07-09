class SavedCard {
  final String id;
  final String bankName;
  final String bankLogo;
  final String cardNumber; // raw digits, no spaces
  final String expiry;
  final String holderName;
  final bool isGold;

  const SavedCard({
    required this.id,
    required this.bankName,
    required this.bankLogo,
    required this.cardNumber,
    required this.expiry,
    required this.holderName,
    this.isGold = false,
  });

  String get last4 => cardNumber.length >= 4
      ? cardNumber.substring(cardNumber.length - 4)
      : cardNumber;

  String get maskedNumber => '**** $last4';
}

class BankOption {
  final String name;
  final String logo;
  const BankOption(this.name, this.logo);
}

const List<BankOption> kBanks = [
  BankOption('Rysgal bank', 'assets/images/icon/rysgal.png'),
  BankOption('Halk bank', 'assets/images/icon/halkbank.png'),
  BankOption('Senagat bank', 'assets/images/icon/senagat.png'),
];
