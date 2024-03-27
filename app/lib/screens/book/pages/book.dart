/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boxicons/boxicons.dart';

import 'package:getout/screens/book/pages/book_description.dart';
import 'package:getout/screens/book/bloc/book_bloc.dart';

class BookSuccessWidget extends StatelessWidget {
  const BookSuccessWidget({
    super.key,
    required this.book,
  });

  final InfoBookResponse book;

  @override
  Widget build(BuildContext context) {
    String imageUrl = book.posterPath ?? '';
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
          Positioned(
              top: 30,
           right: 140,
              child: IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                  onPressed: () async {
                    await Clipboard.setData(
                        ClipboardData(text: '${book.bookLink}'));
                  })), //todo head
          Positioned(
            top: 30,
            right: 80,
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye),
              color: (book.read ?? false) ? Colors.red : Colors.white,
              onPressed: () async {
                if (book.read == true) {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .removeReadBook(AddBookRequest(id: book.id ?? ''));
                } else {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .addReadBook(AddBookRequest(id: book.id ?? ''));
                }
                if (!context.mounted) return;
                context
                    .read<BookBloc>()
                    .add(CreateInfoBookRequest(id: book.id ?? ''));
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.thumb_up_alt_sharp),
              color: (book.liked ?? false) ? Colors.red : Colors.white,
              onPressed: () async {
                if (book.liked == true) {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .removeLikedBook(AddBookRequest(id: book.id ?? ''));
                } else {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .addLikedBook(AddBookRequest(id: book.id ?? ''));
                }
                if (!context.mounted) return;
                context
                    .read<BookBloc>()
                    .add(CreateInfoBookRequest(id: book.id.toString()));
              },
            ),
          ),
          Positioned(
            top: 80,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.thumb_down),
              color: (book.disliked ?? false) ? Colors.red : Colors.white,
              onPressed: () async {
                if (book.disliked == true) {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .removeDislikedBook(AddBookRequest(id: book.id ?? ''));
                } else {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .addDislikedBook(AddBookRequest(id: book.id ?? ''));
                }
                if (!context.mounted) return;
                context
                    .read<BookBloc>()
                    .add(CreateInfoBookRequest(id: book.id.toString()));
              },
            ),
          ),
          Positioned(
            top: 130,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.add_circle_outlined),
              color: (book.wishlisted ?? false) ? Colors.red : Colors.white,
              onPressed: () async {
                if (book.wishlisted == true) {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .removeWishlistedBook(AddBookRequest(id: book.id ?? ''));
                } else {
                  await context
                      .read<BookBloc>()
                      .bookService
                      .addWishlistedBook(AddBookRequest(id: book.id ?? ''));
                }
                if (!context.mounted) return;
                context
                    .read<BookBloc>()
                    .add(CreateInfoBookRequest(id: book.id ?? ''));
              },
            ),
          ),
        ],
      ),
      Text(
        book.title ?? 'N/A',
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
          Text('${book.pageCount.toString()} pages',
              // widget.book.duration,
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
              maxLines: 11,
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
