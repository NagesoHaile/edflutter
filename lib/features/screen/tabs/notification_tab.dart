import 'package:edir/features/widgets/custom_news_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:edir/core/constants/global_url.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  List<dynamic> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('${GlobalUrl.url}/api/notifications/'));

    if (response.statusCode == 200) {
      setState(() {
        notifications = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Notifications & News'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(notification['notification_title']),
            subtitle: Text(notification['notification_description']),
          );
        },
      ),
    );
  }
}


// SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             //padding: const EdgeInsets.all(10.0),
//             child: const Column(
//               children: [
//                 CustomeNewsCard(),
//               ],
//             ),
//           ),
//         ),
//       ),