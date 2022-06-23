import 'package:easy_money/db/category/category_db.dart';
import 'package:easy_money/db/transactions/transaction_db.dart';
import 'package:easy_money/model/category/category_model.dart';
import 'package:easy_money/model/transactions/tranasaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDb.instance.transactionListNotifer,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDb.instance.deleteTransactions(_value.id!);
                      },
                      icon: Icons.delete,
                      label: "Delete",
                    )
                  ],
                ),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      child: Text(
                        parseDate(_value.date),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: _value.type == CategoryType.income
                          ? Colors.green[500]
                          : Colors.red[500],
                    ),
                    title: Text(
                      "₹ ${_value.amount}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _value.type == CategoryType.income
                              ? Colors.green[500]
                              : Colors.red[500]),
                    ),
                    subtitle: Text(
                      "${_value.purpose}  - ${_value.category.name}",
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    // final _data = DateFormat.MMMd().format(date);
    // final _splitedDate = _data.split("");
    // return "${_splitedDate.last}\n${_splitedDate.first}";
    //return "${date.day}\n${date.month}";
    return DateFormat.MMMd().format(date);
  }
}
