import 'dart:developer';

import 'package:easy_money/db/category/category_db.dart';
import 'package:easy_money/db/transactions/transaction_db.dart';
import 'package:easy_money/model/category/category_model.dart';
import 'package:easy_money/model/transactions/tranasaction_model.dart';
import 'package:flutter/material.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = "Add-Transactions";
  const ScreenAddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  final _purposeTextEdingController = TextEditingController();
  final _amountTextEdingController = TextEditingController();

  @override
  void initState() {
    _selectCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transactions"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ///Purpose TextField
            TextFormField(
              controller: _purposeTextEdingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Purpose",
              ),
            ),
            const SizedBox(height: 10),

            ///Amount
            TextFormField(
              controller: _amountTextEdingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Amount",
              ),
              keyboardType: TextInputType.number,
            ),
            //Select Date

            TextButton.icon(
                onPressed: () async {
                  final _selectDateTemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (_selectDateTemp == null) {
                    return;
                  } else {
                    log(_selectDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month),
                label: Text(
                  _selectedDate == null
                      ? "Select Date"
                      : _selectedDate.toString(),
                )),

            ///Income or Expense Radio Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectCategorytype,
                      onChanged: (newValue) {
                        setState(() {
                          _selectCategorytype = CategoryType.income;
                          _categoryID = null;
                        });
                      },
                    ),
                    const Text("Income")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.expense,
                        groupValue: _selectCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectCategorytype = CategoryType.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text("Expense")
                  ],
                ),
              ],
            ),
            // Category DropDown

            DropdownButton<String>(
              hint: const Text("Select Category"),
              value: _categoryID,
              items: (_selectCategorytype == CategoryType.income
                      ? CategoryDB().icomeCategoryListListener
                      : CategoryDB().expenseCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    _selectedCategoryModel = e;
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                print(selectedValue);
                setState(() {
                  _categoryID = selectedValue;
                });
              },
              onTap: () {},
            ),
            ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposText = _purposeTextEdingController.text;
    final _amountText = _amountTextEdingController.text;
    if (_purposText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if (_categoryID == null) {
    //   return;
    // }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final _paresdAmount = double.tryParse(_amountText);
    if (_paresdAmount == null) {
      return;
    }
    final _model = TransactionModel(
      purpose: _purposText,
      amount: _paresdAmount,
      date: _selectedDate!,
      type: _selectCategorytype!,
      category: _selectedCategoryModel!,
    );
    await TransactionDb.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDb.instance.refresh();
  }
}
