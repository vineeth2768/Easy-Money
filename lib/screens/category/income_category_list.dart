import 'package:flutter/material.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text("Icome Category $index"),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          );
        },
        separatorBuilder: (ctx, index) {
          return const Divider(
            thickness: 5,
          );
        },
        itemCount: 25);
  }
}
