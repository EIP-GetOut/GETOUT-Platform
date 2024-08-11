import 'package:flutter/material.dart';


class RefreshTimeCard extends StatelessWidget {
  const RefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card.outlined(
        shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor , width: 2), // Couleur et épaisseur de la bordure
        borderRadius: BorderRadius.circular(25), // Rayon des coins
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time_filled, color:  Theme.of(context).primaryColor, size: 30,),
              title: Text('Rafraichissement de vos recommandations dans 23h', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
