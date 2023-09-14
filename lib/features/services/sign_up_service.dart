import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:edir/core/models/user.dart';
import 'package:edir/core/widgets/custom_snack_bar.dart';
import 'package:edir/core/constants/global_url.dart';
import 'package:edir/core/errors/http_error_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpService {
  Future<void> signUpUser({
    required BuildContext context,
    required String firstName,
    required String middleName,
    required String lastName,
    required String username,
    required String password,
  }) async {
    final url = Uri.parse('${GlobalUrl.url}/auth/users/');
    try {
      User user = User(
        username: username,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        password: password,
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
          'username': username,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        print('user registered successfully');
      } else {
        print('Registration failed with status code: ${response.statusCode}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('error_message')) {
          print('Error message: ${responseData['error_message']}');
        }
      }

      HttpErrorHandling.handleHttpError(
          context: context,
          response: response,
          onSuccess: () async {
            CustomSnackBar.showSnackBar(
              context: context,
              text: 'User Register sucessfully. Login with the same credential',
            );
            final prefs = await SharedPreferences.getInstance();
            final registered = prefs.setBool('registered', true);
          });
    } catch (error) {
      CustomSnackBar.showSnackBar(
        context: context,
        text: error.toString(),
      );
    }
  }
}
