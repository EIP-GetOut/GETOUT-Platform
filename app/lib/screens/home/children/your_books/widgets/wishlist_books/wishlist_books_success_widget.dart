/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/children/your_books/widgets/common/title.dart';
import 'package:getout/screens/home/children/your_books/widgets/common/poster_and_description.dart';
import 'package:getout/screens/book/bloc/book_provider.dart';
import 'package:getout/screens/home/children/your_books/bloc/wishlist_books/wishlist_books_bloc.dart';

class WishlistBooksSuccessWidget extends StatelessWidget {
  WishlistBooksSuccessWidget({
    super.key,
    required this.books,
  });

  final List<WishlistBookPreview> books;

  final PageController bookController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'books_emoji', title: 'La liste de vos souhaits'),
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
