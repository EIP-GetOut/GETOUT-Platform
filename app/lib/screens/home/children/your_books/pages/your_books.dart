/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/children/dashboard/widgets/books/books_widget.dart';
import 'package:getout/screens/home/children/your_books/widgets/like_books/like_books_widget.dart';
import 'package:getout/screens/home/children/your_books/widgets/view_books/view_books_widget.dart';
import 'package:getout/screens/home/children/your_books/widgets/wishlist_books/wishlist_books_widget.dart';

class YourBooksLayout extends StatelessWidget {
  const YourBooksLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [BooksWidget(), WishlistBooksWidget(), LikeBooksWidget(), ViewBooksWidget()],
        ));
  }
}
