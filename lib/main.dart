import 'package:flutter/material.dart';
import 'package:transaction_app/widgets/new_transaction.dart';
import 'package:transaction_app/widgets/transaction_list.dart';
import 'models/transactions.dart';
import './widgets/chart.dart';

void main() {
  runApp(const TransactionApp());
}

class TransactionApp extends StatefulWidget {
  const TransactionApp({super.key});

  @override
  State<TransactionApp> createState() => _TransactionAppState();
}

class _TransactionAppState extends State<TransactionApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransaction = [
    // Transaction(
    //   id: 'T1',
    //   title: 'New Shoes',
    //   amount: 1000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T2',
    //   title: 'Shirt',
    //   amount: 400,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransaction {
    return _usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
    );

    setState(
      () {
        _usertransaction.add(newTx);
      },
    );
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Colors.pink.shade600,
      centerTitle: true,
      title: Text(
        'Personal Expenses',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w700),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: appbar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(
            Icons.add,
            color: Colors.pink,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top) * .3 ,
                  child: Chart(_recentTransaction)),
              Container(
                  height: (MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top) * .7,
                  child: TransactionList(_usertransaction, _deleteTransaction)),
            ],
          ),
        ),
      ),
    );
  }
}
