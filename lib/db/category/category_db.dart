import 'package:easy_money/model/category/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

const CATEGORY_DB_NAME = "category-database";

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModel>> icomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCAtegoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.add(value);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCAtegories = await getCategories();
    await Future.forEach(_allCAtegories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        icomeCategoryList.value.add(category);
      } else {
        expenseCAtegoryList.value.add(category);
      }
    });
  }
}
