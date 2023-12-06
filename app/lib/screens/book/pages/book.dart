/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:boxicons/boxicons.dart';

import 'package:getout/screens/book/pages/book_description.dart';
import 'package:getout/screens/book/bloc/book_bloc.dart';

class BookSuccessWidget extends StatelessWidget {
  const BookSuccessWidget({
    Key? key,
    required this.book,
  }) : super(key: key);

  final InfoBookResponse book;

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        /*'https://image.tmdb.org/t/p/w600_and_h900_bestv2${*/book.posterPath ?? ''/*}'*/;
    Widget buildCoverImage() => Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromRGBO(213, 86, 65, 0.992),
                width: 10.0,
              ),
            ),
          ),
          child: Image.network(
            imageUrl,
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.6),
            colorBlendMode: BlendMode.modulate,
            width: double.infinity,
            fit: BoxFit.cover,
            height: 200,
          ),
        );

    Widget buildLittleImage() => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(imageUrl, height: 250));

    return Column(children: [
      // AppBar(leading: const BackButton()),
      Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 150),
            child: buildCoverImage(),
          ),
          Positioned(
            top: 100,
            child: buildLittleImage(),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 250, right: 340),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))),
        ],
      ),
      Text(
        book.title ?? 'N/A',
        textScaleFactor: 0.9,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Icon(
            Boxicons.bx_book,
            size: 40,
          ),
          SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 30,
                color: Colors.black,
                thickness: 1,
                // heigth : double.infinity,
              )),
          Icon(Boxicons.bx_time, size: 40),
        ],
      ),
      Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Row contents horizontally,
        crossAxisAlignment: CrossAxisAlignment
            .center, //Center Row contents vertically,            children: [
        children: [
          Text('Livre',
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 15),
          const SizedBox(
              height: 20,
              child: VerticalDivider(
                width: 10,
                // color: Colors.black,
                thickness: 0,
                // height : double.infinity,
              )),
          Text(book.duration ?? 'N/A',
              // widget.book.duration,
              textScaleFactor: 0.9,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(book.overview ?? 'Aucune description disponible',
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              textScaleFactor: 0.9,
              style: Theme.of(context).textTheme.bodySmall),
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDescriptionPage(book: book)));
        },
        child: const Text(
          'voir plus >',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
