/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/book/bloc/book_provider.dart';
import 'package:getout/screens/home/children/dashboard/widgets/common/poster_and_description.dart';
import 'package:getout/screens/home/children/dashboard/widgets/common/title.dart';
import 'package:getout/screens/home/children/your_books/bloc/like_books/like_books_bloc.dart';

class LikeBooksSuccessWidget extends StatelessWidget {
  LikeBooksSuccessWidget({
    super.key,
    required this.books,
  });

  final List<LikeBookPreview> books;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        const TitleWidget(
            asset: 'popcorn_emoji', title: 'Les films que vous allez aimer'),
        Expanded(
            child: ListView(
                controller: movieController,
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
