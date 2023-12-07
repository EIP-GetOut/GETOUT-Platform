/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/widgets/common/header.dart';
import 'package:getout/screens/home/widgets/movies/movies_widget.dart';
import 'package:getout/screens/home/widgets/books/books_widget.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  // test push
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DashboardHeader(), MoviesWidget(), BooksWidget()],
        ));
  }
}
