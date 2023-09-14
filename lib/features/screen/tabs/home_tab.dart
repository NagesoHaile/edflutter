import 'package:edir/core/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:edir/core/constants/colors.dart';
import 'package:edir/core/constants/global_url.dart';
import 'package:edir/features/screen/sign_in_screen.dart';
import 'package:edir/features/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:edir/core/models/user.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  Future<User>? userDataFuture;

  @override
  void initState() {
    super.initState();
    userDataFuture =
        fetchUserData(); // Call the function in the appropriate lifecycle method
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('access_token');
  }

  Future<User> fetchUserData() async {
    String? username;
    String? firstName;
    String? lastName;
    String? middleName;
    try {
      final accessToken = await getAccessToken();
      //print('access token:-----${accessToken}');
      if (accessToken != null) {
        // Use the access token to fetch user data as shown in previous responses
        final user = await SignInService.fetchUserData(accessToken);
        username = user.username;
        firstName = user.firstName;
        middleName = user.middleName;
        lastName = user.lastName;
        print(firstName);
        // ...
      } else {
        // Handle the case where the access token is not available
        throw Exception('Access token not available.');
      }
    } catch (e) {
      print(e.toString());
    }
    return User(
        username: username.toString(),
        password: '',
        firstName: firstName.toString(),
        middleName: middleName.toString(),
        lastName: lastName.toString());
  }

  @override
  Widget build(BuildContext context) {
    // print(accessToken);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<User>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No user data available.'));
            } else {
              final user = snapshot.data!;
              return SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Hello,',
                              style: const TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              '${user.firstName}!',
                              style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20.0),
                            )
                          ],
                        ),
                        Text(
                          'Collaborate and Stregthen your socail connection!',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
