/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/connection/pages/login.dart';
import 'package:getout/screens/settings/pages/edit_password.dart';
import 'package:getout/screens/connection/widgets/cookieJar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final CookieManager authService = CookieManager();

  @override
  bool isActivated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          'Paramètres',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            decorationThickness: 4,
            decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
            decoration: TextDecoration.underline,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'COMPTE',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 20, thickness: 1),
            buildParameters(context, 'Changer le Mot de Passe',
                const ParametersEditPasswordPage()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.email_outlined, color: Colors.grey),
                  Text("changer d'adresse mail",
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.delete, color: Colors.grey),
                  const Text('supprimer son compte',
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'APPARENCE',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.public, color: Colors.grey),
                  Text('choisir la langue',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.visibility, color: Colors.grey),
                  Text('dark mode',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isActivated = !isActivated;
                      });
                    },
                    child: Container(
                      width: 60.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: isActivated ? Colors.grey : Colors.grey,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.6),
                          width: 3,
                        ),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            left: isActivated ? 30.0 : 0.0,
                            right: isActivated ? 0.0 : 30.0,
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'PREFERENCE',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.settings, color: Colors.grey),
                  Text('changer les preferences',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.notifications, color: Colors.grey),
                  Text('notifications',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'AUTRE',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.help_outline, color: Colors.grey),
                  Text('support',
                      style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text('Déconection',
                    style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {
                  authService.deleteAllCookies().then(
                    (_) {
                      authService.createCookie();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConnectionPage()),
                      );
                    },
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

GestureDetector buildParameters(
    BuildContext context, String title, StatefulWidget page) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.lock, color: Colors.grey),
            Text(title,
                style: TextStyle(fontSize: 20, color: Colors.grey[800])),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[800])
          ],
        )),
  );
}
