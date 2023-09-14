import 'package:edir/core/constants/colors.dart';
import 'package:edir/core/models/user.dart';
import 'package:edir/features/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
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
              child: Container(
                padding: const EdgeInsets.only(
                    top: 15.0, left: 10.0, right: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Icon(
                              Icons.person_2_rounded,
                              size: 40.0,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${user.firstName} ${user.middleName}',
                            style: GoogleFonts.sansita(
                                fontSize: 18.0, color: AppColors.white),
                          ),
                          Text(
                            '@${user.username}',
                            style:
                                GoogleFonts.sansita(color: AppColors.lightGrey),
                          )
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       child: CircleAvatar(
                    //         child: Icon(Icons.person),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Divider(),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const InformationScreen(),
                          //   ),
                          // );
                        },
                        leading: Icon(Icons.info),
                        title: Text('My Information'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        leading: Icon(Icons.star_border),
                        title: Text('Membership'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Other Settings'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        leading: Icon(Icons.security),
                        title: Text('Terms and Policies'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 0.2,
                      child: ListTile(
                        leading: Icon(Icons.help_center_outlined),
                        title: Text('Help'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      elevation: 0.1,
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
