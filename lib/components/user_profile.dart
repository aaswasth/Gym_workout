import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  String _userEmail = '';
  String _name = '';
  int _age = 0;
  double _weight = 0.0;
  double _height = 0.0;
  String _gender = '';

  String get userEmail => _userEmail;
  String get name => _name;
  int get age => _age;
  double get weight => _weight;
  double get height => _height;
  String get gender => _gender;

  void updateProfile({
    String? userEmail,
    String? name,
    int? age,
    double? weight,
    double? height,
    String? gender,
  }) {
    if (userEmail != null) _userEmail = userEmail;
    if (name != null) _name = name;
    if (age != null) _age = age;
    if (weight != null) _weight = weight;
    if (height != null) _height = height;
    if (gender != null) _gender = gender;

    notifyListeners();
  }
}
