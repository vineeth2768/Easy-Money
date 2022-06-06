import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (ctx, index) {
          return const Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    "22\nJAN",
                    textAlign: TextAlign.center,
                  )),
              title: Text("2000"),
              subtitle: Text("Traval"),
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(height: 10);
        },
        itemCount: 10);
  }
}
