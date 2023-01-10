import 'package:flutter/material.dart';
import 'package:flutter_map_demo/models/user_model.dart';
import 'package:flutter_map_demo/services/user_model_factory.dart';

class UserModelProvider extends ChangeNotifier {
  UserModelProvider(this.userService);
  final UserModelFactory userService;

  List<UserModel> _users = [];

  List<UserModel> get users => _users;

  UserModel getUser() {
    return userService.generateFake();
  }

  List<UserModel> _getUsers({int length = 10}) {
    return userService.generateFakeList(length: length);
  }

  void init() {
    if (users.isEmpty) {
      _users = _getUsers();
    }
  }

  void resetUsers() {
    _users = _getUsers();
    notifyListeners();
  }
}
