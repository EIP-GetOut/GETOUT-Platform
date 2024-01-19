/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/book/bloc/book_provider.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/widgets/common/book_preview_widget.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';

class LikedBooksSuccessWidget extends StatelessWidget {
  LikedBooksSuccessWidget({
    super.key,
    required this.books,
  });

  final List<BookPreview> books;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'heart_emoji', title: 'Vos coup de coeurs'),
        Expanded(
            child: ListView(
                controller: movieController,
                scrollDirection: Axis.horizontal,
                children: List.generate(books.length, (index) {
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
