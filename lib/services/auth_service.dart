import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shamo/main.dart';
import 'package:shamo/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shamo/session_manager.dart';
import 'package:shamo/theme.dart';

class AuthService {
  String baseUrl = UrlAPI().baseUrl;

  Future<UserModel> register({
    String? name,
    String? username,
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ${data['access_token']}';

      return user;
    } else {
      throw Exception('Gagal Register!');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);

      String token = "Bearer ${data['access_token']}";
      user.token = token;

      mainStorage.put("token", token);
      print("token: $token");

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> fetchUser() async {
    // get token
    String token = mainStorage.get("token");

    var response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);
      user.token = token;

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> update({
    required String token,
    required String name,
    required String email,
    required String username,
  }) async {
    var response = await http.post(
      Uri.parse('$baseUrl/user'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': token,
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "username": username,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data);

      return user;
    } else {
      throw Exception("Gagal Memperbarui Profile");
    }
  }

  logout({
    required BuildContext context,
    required String token,
  }) async {
    var response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': token,
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      mainStorage.put('token', '');

      Navigator.restorablePushNamedAndRemoveUntil(
          context, '/login', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            'Berhasil Logout',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      throw Exception("Gagal Memperbarui Profile");
    }
  }
}
