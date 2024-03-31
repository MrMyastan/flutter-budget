enum Direction { cost, benefit }

class Transaction {
  double amount;
  Direction direction;
  String formattedAmount;
  DateTime date;
  String name;
  int id;

  Transaction(this.amount, this.formattedAmount, this.direction, this.date,
      this.name, this.id);
}
