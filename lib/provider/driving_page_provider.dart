import 'package:flutter/material.dart';

class DrivingPageProvider extends ChangeNotifier {
  String _message = 'you have not given your age yet';
  bool _isEligible = false;

  String get message => _message;
  bool get isEligible => _isEligible;
  void checkEligible(int age) {
    if (age >= 18) {
      eligible();
    } else {
      notEligible();
    }
  }

  void eligible() {
    _message = 'You are Eligible';
    _isEligible = true;
    notifyListeners();
  }

  void notEligible() {
    _message = 'You are Not Eligible';
    _isEligible = false;
    notifyListeners();
  }
}
