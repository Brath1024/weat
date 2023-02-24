// ignore_for_file: slash_for_doc_comments, unused_field, prefer_conditional_assignment, prefer_final_fields, unused_local_variable, avoid_print, unused_import, prefer_const_constructors, unused_element

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class IndexViewModel extends ChangeNotifier {
  bool? isLotte = false;
  Map? currentDishes = {};

  bool? get getIsLotte {
    return isLotte;
  }

  void setIsLotte(bool isLotte) {
    this.isLotte = isLotte;
    notifyListeners();
  }

  Map? get getCurrentDishes {
    return currentDishes;
  }

  void setCurrentDishes(Map currentDishes) {
    this.currentDishes = currentDishes;
    notifyListeners();
  }
}
