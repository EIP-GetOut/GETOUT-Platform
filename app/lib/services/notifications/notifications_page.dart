import 'package:flutter/material.dart';
import 'notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';


class NotificationsPage extends StatefulWidget  {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  NotificationsServices notificationsServices = NotificationsServices();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NOTIFICATIONS'),
          leading: const BackButton(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            children: [
            const SizedBox(height: 50),
              Container(
              color : Colors.grey[500],
              width: 500,
              height: 30,
              child: const Text('Notifications Push', style: TextStyle(fontSize: 20, color: Colors.white, )),
            ),
            const SizedBox(height: 30),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Recommandations', style: TextStyle(fontSize: 20, color: Colors.grey[800])),
            FlutterSwitch(
              height: 35.0,
              width: 65.0,
              padding: 6.0,
              toggleSize: 20.0,
              borderRadius: 20.0,
                value: status,
                activeColor: const Color.fromRGBO(213, 86, 65, 1),
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
            ),
        ])])));
        // Center(
        //   child: Column(
        //     children: [
        //   ElevatedButton(
        //     onPressed: () {
        //       notificationsServices.sendNotif();
        //     },
        //     child: Text('Show Notification'),
        //   ),
        //             ElevatedButton(
        //     onPressed: () {
        //       notificationsServices.stopNotif();
        //     },
        //     child: Text('Stop Notification'),
        //   )
        // ]),
        // )
  }
}