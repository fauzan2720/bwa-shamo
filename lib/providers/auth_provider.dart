import 'package:flutter/cupertino.dart';
import 'package:shamo/models/user_model.dart';
import 'package:shamo/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  // menambahkan function untuk melakukan register
  Future<bool> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user; // kalau berhasil kita akan mengganti _user nya adalah user;

      return true; // diartikan kita berhasil mendaftar
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> fetchUser() async {
    try {
      UserModel user = await AuthService().fetchUser();
      _user = user;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> update({
    required String token,
    required String name,
    required String email,
    required String username,
  }) async {
    try {
      UserModel user = await AuthService().update(
        token: token,
        name: name,
        email: email,
        username: username,
      );
      user.token = token;
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
