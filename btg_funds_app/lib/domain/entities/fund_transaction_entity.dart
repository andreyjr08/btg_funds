enum TransactionType { subscribe, cancel }

class FundTransaction {
  final int fundId;
  final String fundName;
  final double amount;
  final TransactionType type;
  final DateTime date;

  FundTransaction({
    required this.fundId,
    required this.fundName,
    required this.amount,
    required this.type,
    required this.date,
  });
}
