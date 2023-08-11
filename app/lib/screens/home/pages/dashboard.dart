import 'package:flutter/material.dart';

import 'package:getout/screens/home/widgets/common/header.dart';
import 'package:getout/screens/home/widgets/movies/movies_widget.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [DashboardHeader(), MoviesWidget()],
        ));
  }
}
