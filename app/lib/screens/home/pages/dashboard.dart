import 'package:flutter/material.dart';

import 'package:getout/screens/home/pages/header.dart';
import 'package:getout/screens/home/pages/movies.dart';
// import 'package:getout/screens/home/pages/books.dart';
import 'package:getout/screens/home/bloc/movie_widget.dart';

// import 'package:infogames/ui/home/widgets/all_games_widget/all_games_widget.dart';
// import 'package:infogames/ui/home/widgets/category_widget/categories_widget.dart';
// import 'package:infogames/ui/home/widgets/games_by_category_widget/games_by_category_widget.dart';
// import 'package:infogames/ui/home/widgets/header_title/header_title.dart';

// import 'package:infogames/ui/widgets/container_body.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // DashboardHeader(),
            children: [MoviesWidget()],
          )),
    );
  }
}
