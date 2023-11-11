import 'package:flutter/material.dart';
import 'notifications.dart';


class HomeScreen extends StatefulWidget  {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationsServices notificationsServices = NotificationsServices();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Local Notifications')),
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