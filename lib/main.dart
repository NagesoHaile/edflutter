import 'package:edir/core/constants/global_url.dart';
import 'package:edir/features/screen/home.dart';
import 'package:edir/features/screen/sign_in_screen.dart';
import 'package:edir/features/screen/sign_up_screen.dart';
import 'package:edir/features/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:edir/core/controllers/controller.dart';
import 'package:edir/core/routes/routing.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SignInService _signInService = SignInService();

  // void getUserData() async {
  //   final accessToken = await _signInService.getAccessToken();

  //   if (accessToken != null) {
  //     final response = await http.get(
  //       Uri.parse('${GlobalUrl}/auth/users/me/'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       },
  //     );
  //     if (response.statusCode == 200) {}
  //   }

  //   await _signInService.fetchUserData(accessToken.toString());

  //   if (tokenController.accessTokenCounter == 1) {
  //     await _signInService.getUserData();
  //   }

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings routeSettings) =>
          generateRoute(routeSettings),
      debugShowCheckedModeBanner: false,
      // home: Home()
      home: userController.user.username.isNotEmpty
          ? Home()
          : const SignInScreen(),
    );
  }
}
