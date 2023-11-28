import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/dashboard/dashboard_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Changement d\'adresse e-mail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMailPage(),
    );
  }
}

class MyMailPage extends StatefulWidget {
  const MyMailPage({super.key});

  @override
  State<MyMailPage> createState() => _MyMailPageState();
}

class _MyMailPageState extends State<MyMailPage> {
  final TextEditingController oldEmailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          "Changement d'adresse mail",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: oldEmailController,
              decoration:
                  const InputDecoration(labelText: 'Ancienne adresse e-mail'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: newEmailController,
              decoration:
                  const InputDecoration(labelText: 'Nouvelle adresse e-mail'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmEmailController,
              decoration: const InputDecoration(
                  labelText: 'Confirmer la nouvelle adresse e-mail'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _validateEmails();
              },
              child: const Text('Valider'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateEmails() {
    String oldEmail = oldEmailController.text;
    String newEmail = newEmailController.text;
    String confirmEmail = confirmEmailController.text;

    if (_isValidEmail(oldEmail) &&
        _isValidEmail(newEmail) &&
        _isValidEmail(confirmEmail)) {
      if (newEmail != confirmEmail) {
        _showErrorDialog('Les adresses e-mail ne correspondent pas.');
        return;
      }

      // Changements enregistrés avec succès
      _showSuccessDialog('Changements enregistrés avec succès !');
    } else {
      _showErrorDialog('Veuillez entrer des adresses e-mail valides.');
    }
  }

  bool _isValidEmail(String email) {
    // Utiliser une expression régulière pour valider l'adresse e-mail
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Succès'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
