import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor , width: 2),
        borderRadius: BorderRadius.circular(25),),
        child: Stack(
          children: <Widget>[
            // Image en arrière-plan
            Image.network(
              "https://media.ouest-france.fr/v1/pictures/MjAyNDA1MTE3NGE5YWUzMjVmYzRjM2I3YzNmODBlMmU0YWI0Yzc?width=1260&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=eee2fc2d863daae83cce5bfed30764d2db552be1832f38238548bc53ab643268",
              fit: BoxFit.cover,
              height: 150,
              width: 100,
              color: const Color.fromRGBO(150, 150, 150, 255).withOpacity(1),
                colorBlendMode: BlendMode.modulate,

            ),

            // Texte superposé à l'image
            Positioned(
              bottom: 10, // Ajuste la position verticale du texte
              left: 10, // Ajuste la position horizontale du texte
              right: 10, // Ajuste la position horizontale du texte
              child: Text(
                "TikTok, Instagram, X...Les Français s'inquiètent des réseaux sociaux et demandent plus de régulation",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  // backgroundColor: Colors.black54, // Fond semi-transparent pour améliorer la lisibilité
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]
        ),
      )
      );
  }
}
