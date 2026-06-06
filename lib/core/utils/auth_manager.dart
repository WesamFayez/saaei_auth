import 'package:flutter/foundation.dart';
import '../../features/auth/domain/entities/user_entity.dart';

enum UserType { guest, user, office }

class AuthManager extends ChangeNotifier {
  static final AuthManager _instance = AuthManager._internal();
  factory AuthManager() => _instance;
  AuthManager._internal();

  static AuthManager get shared => _instance;

  bool _loggedIn = true;
  bool get isLoggedIn => _loggedIn;

  UserEntity? _user;
  UserEntity? get user => _user;

  String? _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjc4OSIsImlzcyI6InNhYWVpIiwiaWF0IjoxNzc1MDUyOTgwMjQxLCJleHAiOjE3NzUwNTM1ODUwNDF9.BXXR4p-4EuzIv-xQPYwYIY-SDDCJprqF3-JFRP2RVxU";
  String? get token => _token;

  UserType userType = UserType.user;

  void loginUser(UserEntity user) {
    _user = user;
    _token = user.token;
    _loggedIn = true;
    userType = user.userInfo?.type == "OFFICE" ? UserType.office : UserType.user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    _loggedIn = false;
    userType = UserType.guest;
    notifyListeners();
  }
}
