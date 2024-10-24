/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_provider.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/liked_books/liked_books_bloc.dart';
import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/home/widgets/common/title_widget.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/tag.dart';

class RecommendedBooksSuccessWidget extends StatelessWidget {
  final List<BookPreview> books;

  const RecommendedBooksSuccessWidget({
    super.key,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
        child: Column(
      children: [
        TitleWidget(
            asset: 'fire',
            title: appL10n(context)!.book_recommendations,
            isBooks: true),
        const SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(
            height: 250.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
          ),
          items: books.map((book) {
            return Builder(builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<LikedBooksHydratedBloc>(
                                    context),
                                child: BlocProvider.value(
                                    value:
                                        BlocProvider.of<SavedBooksHydratedBloc>(
                                            context),
                                    child: BlocProvider.value(
                                        value: BlocProvider.of<
                                            WatchedBooksHydratedBloc>(context),
                                        child: Book(book.id))))));
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(book.posterPath ?? '')),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Clip it cleanly.
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(book.posterPath ?? '')),
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(book.title,
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              overflow: TextOverflow.ellipsis)),
                                      const SizedBox(height: 10),
                                        if (book.releaseDate != null)
                                          Text(
                                              book.releaseDate!.substring(0, 4),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight:
                                                      FontWeight.normal)),
                                      const SizedBox(height: 10),
                                      if (book.genres != null &&
                                          book.genres!.isNotEmpty)
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Wrap(
                                                spacing: 8.0,
                                                runSpacing: 4.0,
                                                children: book.genres!
                                                    .map(
                                                        (tag) => Tag(text: tag))
                                                    .toList())),
                                    ]),
                              )),
                        ],
                      )));
            });
          }).toList(),
        ),
      ],
    ));
  }
}
