import 'dart:developer';

import 'package:easy_money/db/category/category_db.dart';
import 'package:easy_money/model/category/category_model.dart';
import 'package:easy_money/screens/add_transactions/screen_add_transaction.dart';
import 'package:easy_money/screens/category/category_add_popup.dart';
import 'package:easy_money/screens/category/screen_category.dart';
import 'package:easy_money/screens/home/widgets/bottom_navigation.dart';
import 'package:easy_money/screens/transaction/screen_transaction.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransactions(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Easy Money"),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: Center(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updateIndex, _) {
                return _pages[updateIndex];
              })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            log("Add Transactions");
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
          } else {
            log("Add Category");
            showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().microsecondsSinceEpoch.toString(),
            //   name: "Traval",
            //   type: CategoryType.expense,
            // );
            // CategoryDB().insertCategory(_sample);
          }
        },
      ),
    );
  }
}
