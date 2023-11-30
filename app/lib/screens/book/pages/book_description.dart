/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';

class BookDescriptionPage extends StatelessWidget {
  final InfoBookResponse book;

  const BookDescriptionPage({super.key, required this.book});

  Widget separateLine() => const Divider(
        height: 15,
        color: Color.fromARGB(255, 192, 192, 192),
        thickness: 10,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DESCRIPTION'),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('RÉSUMÉ',
                        // textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(padding: const EdgeInsets.only(left: 10), child: Text(
                    // textAlign: TextAlign.start,
                    book.overview ?? 'Aucune description disponible')),
                separateLine(),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                        // textAlign: TextAlign.start,
                        'AUTEUR(S)',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/5/5f/Grey.PNG?20071229171831',
                      height: 50,
                      width: 50,
                    )),
                const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Auteur 1')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
