/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/children/dashboard/widgets/common/title.dart';
import 'package:getout/screens/home/children/dashboard/widgets/common/poster_and_description.dart';
import 'package:getout/screens/home/children/dashboard/bloc/books/books_bloc.dart';
import 'package:getout/screens/book/bloc/book_provider.dart';

class BooksSuccessWidget extends StatelessWidget {
  BooksSuccessWidget({
    super.key,
    required this.books,
  });

  final List<BookPreview> books;

  final PageController bookController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
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
                      child: PosterAndDescriptionWidget(
                          posterPath: books[index].posterPath,
                          title: books[index].title,
                          overview: books[index].overview));
                }))),
      ],
    ));
  }
}
