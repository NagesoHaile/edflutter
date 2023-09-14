import 'package:edir/features/widgets/custom_news_card.dart';
import 'package:flutter/material.dart';

class NotificationTab extends StatefulWidget {
  const NotificationTab({super.key});

  @override
  State<NotificationTab> createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Notifications & News'),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Container(
          //padding: const EdgeInsets.all(10.0),
          child: const Column(
            children: [
              CustomeNewsCard(),
            ],
          ),
        ),
      )),
    );
  }
}
