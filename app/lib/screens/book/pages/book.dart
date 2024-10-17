/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/home/bloc/liked_books/liked_books_bloc.dart';
import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/widgets/description_title.dart';
import 'package:getout/screens/book/widgets/action_page.dart';
import 'package:getout/tools/launch_webview.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/tag.dart';

class BookSuccessWidget extends StatelessWidget {
  const BookSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);
    final book = context.read<BookBloc>().state.book;
    final String releaseDate = book.releaseDate ?? '';

    String imageUrl = book.posterPath ?? '';

   List<Tag> tagList() {
      return book.genres!.map((tag) => Tag(text: tag.split('/')[0])).toList();
    }


    Widget buildCoverImage() => Container(
        decoration: const BoxDecoration(
          border: Border(
          ),
        ),
        child: Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                imageUrl,
                // color: const Color.fromRGBO(150, 150, 150, 255).withOpacity(1),
                colorBlendMode: BlendMode.modulate,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
              Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(
                          0.5), // Couleur transparente pour que le flou soit visible
                    ),
                  )),
              Positioned(
                top: 40,
                right: 50,
                child: IconButton(
                  icon: const Icon(Icons.share),
                  color: Colors.white,
                  onPressed: () async {
                    Share.share(
                        "Regarde ce livre que j'ai trouvé grâce à Getout ! ${book.bookLink}");
                  },
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0,
                  child: IconButton(
                      icon: const Icon(Icons.more_vert),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return BlocProvider.value(
                                  value: BlocProvider.of<BookBloc>(context),
                                  child: BlocProvider.value(
                                      value: BlocProvider.of<LikedBooksHydratedBloc>(context),
                                      child: BlocProvider.value(
                                          value: BlocProvider.of<SavedBooksHydratedBloc>(context),
                                          child: BlocProvider.value(
                                              value: BlocProvider.of<WatchedBooksHydratedBloc>(context),
                                              child: const FractionallySizedBox(
                                                  heightFactor: 0.9,
                                                  child: ActionsPageBook())))));
                            });
                      })
              )
            ]
        )
    );

    Widget buildLittleImage() => GestureDetector(
        onTap: () =>
            launchWebView('https://play.google.com/store/books/details?id=${book.id}&source=gbs_api'),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(imageUrl, height: 300)));

    return Center(
        child: ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, value, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 220),
                          child: buildCoverImage(),
                        ),
                        Positioned(
                          top: 100,
                          child: buildLittleImage(),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 300, right: 340),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Text(
                      book.title ?? 'N/A',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star),
                            const SizedBox(width: 2),
                            Text(
                              book.voteAverage != null
                                  ? book.voteAverage.toString()
                                  : 'N/A',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Text(
                          releaseDate != '' ? releaseDate.split('-')[0] : '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('${book.pageCount} pages',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    book.genres != null && book.genres!.isNotEmpty
                        ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: [tagList()[0]],

                        ))
                        : const SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isExpanded,
                            builder: (context, isExpandedValue, child) {
                              return Column(
                                children: [
                                  Text(
                                    book.overview ??
                                        appL10n(context)!.no_description,
                                    textAlign: TextAlign.justify,
                                    overflow: isExpandedValue
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                    maxLines: isExpandedValue ? null : 8,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      isExpanded.value = !isExpanded.value;
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                            isExpandedValue
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 40.0),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    DescriptionTitle(value: appL10n(context)!.author),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: book.authorsPicture != null
                          ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                              NetworkImage(book.authorsPicture![0].picture),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10, top: 10),
                              child: Text(
                                book.authorsPicture![0].name, /// TODO CORRECT THIS
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    ),
                    // DescriptionTitle(value: appL10n(context)!.casting),
                    // const SizedBox(height: 10),
                    /*Padding(
                      padding: const EdgeInsets.all(25),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            book.cast?.length ?? 0,
                                (index) => Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        book.cast![index].picture),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 10),
                                    child: Text(
                                      book.cast![index].name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
*/                  ],
                ),
              );
            }));
  }
}