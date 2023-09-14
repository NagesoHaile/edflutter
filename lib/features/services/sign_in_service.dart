import 'package:edir/core/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:edir/core/constants/global_url.dart';
import 'package:edir/core/controllers/controller.dart';
import 'package:edir/core/errors/http_error_handling.dart';
import 'package:edir/core/models/user.dart';
import 'package:edir/core/widgets/custom_snack_bar.dart';
import 'package:edir/features/screen/home.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class SignInService {
  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token format');
    }

    final payload = parts[1];
    final String decodedPayload =
        String.fromCharCodes(base64Url.decode(payload));
    final Map<String, dynamic> decodedData = jsonDecode(decodedPayload);

    return decodedData;
  }

  Future<void> storeTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final access = prefs.getString('access_token');
    return access;
  }

  Future<void> signInUser({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    //  Uri uri = Uri.parse('https://30a6-213-55-85-43.ngrok-free.app/auth/jwt/create/');
    final url = Uri.parse('${GlobalUrl.url}/auth/jwt/create/');
    print('Request URL: $url');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String accessToken = responseData['access'];
        final String refreshToken = responseData['refresh'];
        // storeTokens(accessToken, refreshToken);
        print(accessToken);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('refresh_token', refreshToken);
        // decodeJwt(accessToken);

        // Check if 'data' key exists in the JSON response
        if (responseData.containsKey('data')) {
          User user = User.fromJson(responseData['data']);
          userController.setUser(user: user);
          storeUserData(username);
        }
        Navigator.pushNamedAndRemoveUntil(
          context,
          Home.routeName,
          (route) => false,
        );
      } else {
        print('Login failed with status code: ${response.statusCode}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('error_message')) {
          print('Error message: ${responseData['error_message']}');
        }
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  Future<void> storeUserData(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    return username;
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  static Future<User> fetchUserData(String accessToken) async {
    final response = await http.get(
      Uri.parse('${GlobalUrl.url}/auth/users/me/'),
      headers: {
        'Authorization': 'JWT $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      print('API Error: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load user data');
    }
  }
}
