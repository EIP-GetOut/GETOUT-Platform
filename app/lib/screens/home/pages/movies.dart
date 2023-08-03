/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
*/

import 'package:flutter/material.dart';
import 'package:getout/screens/home/bloc/movie_bloc.dart';

class MoviesSuccessWidget extends StatelessWidget {
  MoviesSuccessWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  final List<MoviePreview> movies;

  final PageController movieController =
      PageController(viewportFraction: 0.1, initialPage: 0);
  final PageController bookController =
      PageController(viewportFraction: 0.1, initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Image.asset(
              'assets/popcorn_emoji.png',
            ),
            const SizedBox(width: 10),
            const Text('Les films que vous allez aimer',
                style: TextStyle(
                  color: Color(0xFFD55641),
                  fontSize: 23,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        Expanded(
            child: ListView(
                controller: movieController,
                scrollDirection: Axis.horizontal,
                children: List.generate(5, (index) {
                  return InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) =>
                    //               MovieDetailsPage(movies[index])));
                    // },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 100,
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${movies[index].posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(movies[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(right: 13.0),
                            child: Text(
                                movies[index].overview ??
                                    'Aucune description disponible',
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                      ]),
                    ),
                  );
                }))),
      ],
    ));
  }
}
