import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Direction { cost, benefit }

class Transaction {
  Direction direction;
  DateTime date;
  String name;

  Transaction(this.direction, this.date, this.name);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Home(title: 'Flutter Demo Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transaction> transactions = [];

  void _addTransaction(Transaction newTransaction) {
    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(children: <Widget>[
          TransactionMaker(onAdded: _addTransaction),
          DataTable(
              sortColumnIndex: 0,
              columns: const <DataColumn>[
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Direction")),
                DataColumn(label: Text("Date"))
              ],
              rows: transactions
                  .map((e) => DataRow(cells: <DataCell>[
                        DataCell(Text(e.name)),
                        DataCell(
                            Text(e.direction == Direction.cost ? "out" : "in")),
                        DataCell(Text(DateFormat('yyyy-MM-dd').format(e.date)))
                      ]))
                  .toList())
        ]));
  }
}

class TransactionMaker extends StatefulWidget {
  const TransactionMaker({super.key, required this.onAdded});

  final Function(Transaction) onAdded;

  @override
  State<TransactionMaker> createState() => _TransactionMakerState();
}

class _TransactionMakerState extends State<TransactionMaker> {
  Direction transDirection = Direction.cost;
  String _name = "";
  final dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  List<Transaction> transactions = [];
  DateTime date = DateTime.now();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    dateController.dispose();
    super.dispose();
  }

  void _setDirection(Direction? value) {
    if (value != null) {
      setState(() {
        transDirection = value;
      });
    }
  }

  void _setString(String name) {
    setState(() {
      _name = name;
    });
  }

  void _addTransaction() {
    Transaction transaction = Transaction(transDirection, date, _name);
    widget.onAdded(transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                  onChanged: _setString,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Transaction Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Date",
                    border: InputBorder.none,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

                      setState(() {
                        dateController.text = formattedDate;
                        date =
                            pickedDate; //set foratted date to TextField value.
                      });
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: DropdownMenu(
                      dropdownMenuEntries: const <DropdownMenuEntry<Direction>>[
                        DropdownMenuEntry(
                            value: Direction.benefit, label: "In"),
                        DropdownMenuEntry(value: Direction.cost, label: "Out")
                      ],
                      onSelected: _setDirection,
                      label: const Text("Direction"),
                      enableSearch: false,
                      requestFocusOnTap: false,
                      initialSelection: Direction.cost,
                      inputDecorationTheme: Theme.of(context)
                          .inputDecorationTheme
                          .copyWith(
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextButton(
                      onPressed: _addTransaction, child: const Text("Add")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}