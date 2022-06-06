import 'package:easy_money/screens/home/screen_home.dart';
import 'package:flutter/material.dart';

class MoneyManagerBottomNavigation extends StatefulWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  State<MoneyManagerBottomNavigation> createState() =>
      _MoneyManagerBottomNavigationState();
}

class _MoneyManagerBottomNavigationState
    extends State<MoneyManagerBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updateIndex, Widget? _) {
        return BottomNavigationBar(
          currentIndex: updateIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Trasactions"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Category"),
          ],
        );
      },
    );
  }
}
