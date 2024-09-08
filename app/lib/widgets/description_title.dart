
import 'package:flutter/cupertino.dart';

class DescriptionTitle extends StatelessWidget {

  const DescriptionTitle({super.key, required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10, top: 10), //apply padding to all four sides
      child: Text(
        value.toUpperCase(),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}


