import 'package:flutter/material.dart';
import 'package:getout/layouts/home/dashboard.dart';

class PageFin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/Logo.png', width: 70, height: 70),
                  const SizedBox(width: 8.0), // Espacement entre l'icône et le texte
                  Column (children: [const Text('GETOUT', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    const Center(child: Text('Connect to reality', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Image.asset('assets/images/Telephone.png', width: 150, height: 180),
                   Image.asset('assets/images/Dessin.png', width: 200, height: 200),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: Text('VOS REPONSE ONT BIEN ETE ENREGISTRE', textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 0.9,
              child : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(213, 86, 65, 1), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),),
              child: const Text('Decouvrir l application', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
            ),
             ),
          ],
        ),
      ),
    );
  }
}