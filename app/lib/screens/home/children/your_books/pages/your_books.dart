/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/children/your_books/widgets/liked_books/liked_books_widget.dart';
import 'package:getout/screens/home/children/your_books/widgets/saved_books/saved_books_widget.dart';
import 'package:getout/screens/home/widgets/recommended_books/recommended_books_widget.dart';

class YourBooksPage extends StatelessWidget {
  const YourBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [RecommendedBooksWidget(), SavedBooksWidget(), LikedBooksWidget()],
        ));
  }
}
