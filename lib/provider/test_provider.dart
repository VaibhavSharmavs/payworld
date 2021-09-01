import 'dart:collection';

import 'package:flutter/material.dart';

class TestProivder with ChangeNotifier {
  int? selectedRadio;

  HashMap<int, bool> map = new HashMap();

  updateRadio(int? value) {
    selectedRadio = value;
    notifyListeners();
  }

  updateCheckbox(int positon, bool selected) {
    map[positon] = selected;
    notifyListeners();
  }
}
