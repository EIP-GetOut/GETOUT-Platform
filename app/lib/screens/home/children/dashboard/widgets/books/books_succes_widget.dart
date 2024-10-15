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
import 'package:getout/tools/app_l10n.dart';

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
        child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                TitleWidget(
                    asset: 'books', title: appL10n(context)!.book_recommendations, length: books.length, isBooks: true),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
                                        builder: (context) =>
                                            Book(books[index].id)));
                              },
                              child: BookPreviewWidget(
                                posterPath: books[index].posterPath,
                                title: books[index].title,
                              ));
                        }))),
              ],
            )));
  }
}
