/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_provider.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/liked_books/liked_books_bloc.dart';
import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/home/widgets/common/book_preview_widget.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';
import 'package:getout/tools/app_l10n.dart';

class LikedBooksSuccessWidget extends StatelessWidget {
  final List<BookPreview> books;

  const LikedBooksSuccessWidget({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    final PageController bookController =
    PageController(viewportFraction: 0.1, initialPage: 0);

    return SizedBox(
        height: 300,
        child: Column(
      children: [
        TitleWidget(
            asset: 'heart', title: appL10n(context)!.like_books_title, length: books.length),
        Expanded(
            child: ListView(
                controller: bookController,
                scrollDirection: Axis.horizontal,
                children: List.generate(books.length, (index) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                    value: BlocProvider.of<LikedBooksHydratedBloc>(context),
                                    child: BlocProvider.value(
                                        value: BlocProvider.of<SavedBooksHydratedBloc>(context),
                                        child: BlocProvider.value(
                                            value: BlocProvider.of<WatchedBooksHydratedBloc>(context),
                                            child: Book(books[index].id))))));
                      },
                      child: BookPreviewWidget(
                          posterPath: books[index].posterPath,
                          title: books[index].title));
                }))),
      ],
    ));
  }
}
