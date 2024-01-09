import 'package:flutter/material.dart';
import 'notifications.dart';


class NotificationsPage extends StatefulWidget  {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  NotificationsServices notificationsServices = NotificationsServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          leading: const BackButton(),
        ),
        body: Center(
          child: Column(
            children: [
          ElevatedButton(
            onPressed: () {
              notificationsServices.sendNotif();
            },
            child: Text('Show Notification'),
          ),
                    ElevatedButton(
            onPressed: () {
              notificationsServices.stopNotif();
            },
            child: Text('Stop Notification'),
          )
        ]),
        )
      ),
    );
  }
}