import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final String text;

  const Tag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color:  Theme.of(context).primaryColor, // Fond rouge
        borderRadius: BorderRadius.circular(12.0), // Bords arrondis
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Texte blanc
          fontSize: 12.0, // Taille de police
          fontWeight: FontWeight.bold, // Texte en gras
        ),
      ),
    );
  }
}