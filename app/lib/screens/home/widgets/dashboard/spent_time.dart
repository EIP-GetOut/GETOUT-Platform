import 'package:flutter/material.dart';

class SpentTimeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String number;

  const SpentTimeCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card.outlined(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20), child:
          Column(children: [
            Text(title, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500)),
            Icon(icon, color:  Theme.of(context).primaryColor, size: 30),
            Text(number, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500)),
          ],)
        )),
    );
  }
}
