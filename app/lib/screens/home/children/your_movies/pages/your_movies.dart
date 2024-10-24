/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/children/your_movies/widgets/liked_movies/liked_movies_widget.dart';
import 'package:getout/screens/home/children/your_movies/widgets/saved_movies/saved_movies_widget.dart';
import 'package:getout/screens/home/children/your_movies/widgets/watched_movies/watched_movies_widget.dart';
import 'package:getout/screens/home/widgets/recommended_movies/recommended_movies_widget.dart';

class YourMoviesPage extends StatelessWidget {
  final ScrollController scrollController;
  const YourMoviesPage({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
        child: const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [RecommendedMoviesWidget(), SavedMoviesWidget(), LikedMoviesWidget(), WatchedMoviesWidget()],
        )));
  }
}
