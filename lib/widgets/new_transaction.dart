// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(
    this.addTx,
  );

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleinput = TextEditingController();
  final _amountinput = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  void _submitData() {
    final enteredTitle = _titleinput.text;
    final enteredAmount = double.parse(_amountinput.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } 
        setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleinput,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountinput,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(child: Text(_selectedDate == Null ? 'No Date Chosen!' : 'Picked Date :${DateFormat.yMd().format(_selectedDate)}')),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text('Choose Date',
                        style: TextStyle(color: Colors.pink.shade500)),
                  ),
                ],
              ),
            ),
            Container(
              height: 38,
              color: Colors.pink.shade700,
              child: TextButton(
                onPressed: () => _submitData(),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
