import 'dart:collection';

import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  int? selectedRadio;

  HashMap<int, bool> map = new HashMap();

  HashMap<int, Object> selectedRadioMap = new HashMap();

  setSelectedRadio(int? value) {
    selectedRadio = value;
    notifyListeners();
  }

  updateCheckbox(int positon, bool selected) {
    map[positon] = selected;
    notifyListeners();
  }

  // updateRadio(int positon, Object selected) {
  //   selectedRadioMap[positon] = selected;
  //   notifyListeners();
  // }
}
