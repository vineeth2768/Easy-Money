import 'package:easy_money/db/category/category_db.dart';
import 'package:easy_money/model/category/category_model.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().expenseCategoryListListener,
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget? _) {
          return Card(
            child: ListView.separated(
                itemBuilder: (ctx, index) {
                  final category = newlist[index];
                  return ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDB.instance.deleteCategory(category.id);
                        },
                        icon: const Icon(Icons.delete)),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const Divider(
                    thickness: 5,
                  );
                },
                itemCount: newlist.length),
          );
        });
  }
}
