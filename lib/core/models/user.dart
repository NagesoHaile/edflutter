import 'dart:convert';

class User {
  final String firstName;
  final String middleName;
  final String lastName;
  final String username;
  final String password;

  User({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      password: json['password'] ?? '',
    );
  }

  // factory User.fromMap(Map<String, dynamic> json) {
  //   return User(
  //     id: json['id'] as int,
  //     firstName: json['firstName'] as String,
  //     middleName: json['middleName'] as String,
  //     lastName: json['lastName'] as String,
  //     username: json['username'] as String,
  //     password: json['password'] as String,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'username': username,
      'password': password,
    };
  }

  // factory User.fromJson(String source) {
  //   return User.fromMap(json.decode(source));
  // }
  // String toJson() {
  //   return json.encode(toMap());
  // }
}

// class User {
//   final String username;
//   final String firstName;
//   final String middleName;
//   final String lastName;
//   final String password;

//   const User(
//       {required this.username,
//       required this.firstName,
//       required this.middleName,
//       required this.lastName,
//       required this.password});

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       username: map['username'] ?? '',
//       firstName: map['firstName'] ?? '',
//       middleName: map['middleName'] ?? '',
//       lastName: map['lastName'] ?? '',
//       password: map['password'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'firstName': firstName,
//       'middleName': middleName,
//       'lastName': lastName,
//       'username': username,
//       'password': password,
//     };
//   }

//   factory User.fromJson(String source) {
//     return User.fromMap(json.decode(source));
//   }

//   String toJson() {
//     return json.encode(toMap());
//   }
// }



