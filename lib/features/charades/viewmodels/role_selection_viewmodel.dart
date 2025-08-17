import 'package:flutter/material.dart';

class RoleSelectionViewModel extends ChangeNotifier {
  String? _role;

  String? get role => _role;

  void selectRole(String role) {
    _role = role;
    notifyListeners();
  }
}
