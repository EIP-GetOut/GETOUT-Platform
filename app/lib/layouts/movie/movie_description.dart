/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/


import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:boxicons/boxicons.dart';
import 'package:GetOut/models/requests/generate_movies.dart';

class MovieDescriptionPage extends StatefulWidget {
  // const MovieDescriptionPage(this.movie);

  // final MoviePreview movie;

  @override
  State<MovieDescriptionPage> createState() => _MovieDescriptionPageState();
}


class _MovieDescriptionPageState extends State<MovieDescriptionPage> {
  @override

Widget separateLine() =>  Divider(
              height: 15,
              color: Color.fromARGB(255, 192, 192, 192),
              thickness: 10,
            // )
          );

  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
          centerTitle: true,
                  titleSpacing: 0,
          title: const Text(
              'DESCRIPTION',
              style: TextStyle(
              fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
                decorationThickness: 4,
                decorationColor: Color.fromRGBO(213, 86, 65, 0.992),
                decoration: 
                TextDecoration.underline,
                ),
          ),
          leading: const BackButton(),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        
        body: SingleChildScrollView(
        child: Stack(
            children: [ Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:Text(
              "RÉSUMÉ",
              // textAlign: TextAlign.left,
              style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ))),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:
              Text(
                          // textAlign: TextAlign.start,
                          "A METTRE"
                        )
              ),
            separateLine(),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:Text(
              // textAlign: TextAlign.start,
              "RÉALISATEUR",
              style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ))),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:Text(
              // textAlign: TextAlign.start,
              "A METTRE"
            )),
            separateLine(),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:Text(
              // textAlign: TextAlign.start,
              "CASTING",
              style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            )
            )),
            const Padding(
              padding: EdgeInsets.only(left: 10), //apply padding to all four sides
              child:Text(
              // textAlign: TextAlign.start,
              "A METTRE"
            )),
          ],
          
        ),
        ],
        ),
        ), 
      );
  }
}