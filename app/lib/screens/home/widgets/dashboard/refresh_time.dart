import 'package:flutter/material.dart';


class RefreshTimeCard extends StatelessWidget {
  const RefreshTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card.outlined(
        shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).primaryColor , width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time_filled, color:  Theme.of(context).primaryColor, size: 30,),
              title: Text('Rafraichissement de vos recommandations dans 23h', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
