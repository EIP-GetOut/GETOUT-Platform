import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://comarketing-news.fr/');

class StoryNewsCard extends StatelessWidget {
  const StoryNewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () => launchUrl2(),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2), // Couleur et épaisseur de la bordure
          borderRadius: BorderRadius.circular(25),
        ),
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Le saviez-vous ?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/draw/question.png',
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                  ' Les réseaux sociaux sont perçus par les Français comme un danger plutôt qu’un bénéfice pour les enfants et adolescents (81%), la vie privée (78%) et la qualité de l’information (62%).',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text('https://comarketing-news.fr/',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Future<void> launchUrl2() async {
  // if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
  //   throw Exception('Could not launch url");
  // }
  await launchUrl(_url, mode: LaunchMode.inAppWebView);
}
