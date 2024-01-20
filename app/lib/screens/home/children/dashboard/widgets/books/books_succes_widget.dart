/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/widgets/common/book_preview_widget.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';
import 'package:getout/screens/book/bloc/book_provider.dart';

class BooksSuccessWidget extends StatelessWidget {
  final List<BookPreview> books;

  const BooksSuccessWidget({
    super.key,
    required this.books,
  });


  @override
  Widget build(BuildContext context) {
    final PageController bookController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'books_emoji', title: 'Les livres qui vous passionneront'),
        Expanded(
            child: ListView(
                controller: bookController,
                scrollDirection: Axis.horizontal,
                children: List.generate(5, (index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Book(books[index].id)));
                      },
                      child: BookPreviewWidget(
                          posterPath: books[index].posterPath,
                          title: books[index].title,
                          overview: books[index].overview));
                }))),
      ],
    ));
  }
}
