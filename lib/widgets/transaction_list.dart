//import packages 
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
//import model package
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'No Transaction added yet!',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Lottie.asset('animation/Ani.json')
              ],
            )
          : ListView.builder(
              itemBuilder: (ctr, index) {
                return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: FittedBox(
                            child: Text(
                          '\₹${transactions[index].amount}',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.pink.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        onPressed: () => deleteTx(transactions[index].id) ,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red.shade500,
                        ),),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
