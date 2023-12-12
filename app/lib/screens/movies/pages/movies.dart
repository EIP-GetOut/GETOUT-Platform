/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:getout/screens/home/widgets/common/header.dart';
import 'package:getout/screens/movies/widgets/movies_liked/movies_liked_widget.dart';
import 'package:getout/screens/movies/widgets/movies_saved/movies_saved_widget.dart';
import 'package:getout/screens/movies/widgets/movies_recommanded/movies_recommanded_widget.dart';


class MoviesLayout extends StatelessWidget {
  const MoviesLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DashboardHeader(), MoviesRecommandedWidget(), MoviesLikedWidget(), MoviesSavedWidget()],
        ));
  }
}
