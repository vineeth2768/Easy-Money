import 'package:easy_money/db/category/category_db.dart';
import 'package:easy_money/model/category/category_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<CategoryType> _selectCategoryNotifer =
    ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final TextEditingController _nameController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter the category",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  RadioButton(title: "Income", type: CategoryType.income),
                  RadioButton(title: "Expense", type: CategoryType.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameController.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = _selectCategoryNotifer.value;
                    final _category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    CategoryDB().insertCategory(_category);
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Add")),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: _selectCategoryNotifer,
            builder: (BuildContext ctx, CategoryType newValue, Widget? _) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: newValue,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    _selectCategoryNotifer.value = value;
                    _selectCategoryNotifer.notifyListeners();
                    print(value);
                  });
            }),
        Text(title),
      ],
    );
  }
}
