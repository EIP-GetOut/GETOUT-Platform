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
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                        book.overview ?? 'Aucune description disponible',
                        style: Theme.of(context).textTheme.bodySmall))),
                separateLine(),
                const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                        'AUTEUR(S)',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold))),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      book.authorsPicture?.length ?? 0,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Image.network(
                              book.authorsPicture![index].picture,
                              height: 120,
                              width: 120,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                child: Text(
                              book.authorsPicture![index].name,
                              style: const TextStyle(fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
