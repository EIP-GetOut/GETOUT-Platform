/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/liked_books/liked_books_bloc.dart';
import 'package:getout/screens/home/bloc/books/books_event.dart';
import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/widgets/show_snack_bar.dart';
import 'package:getout/tools/app_l10n.dart';


class ActionsPageBook extends StatelessWidget {
  const ActionsPageBook({super.key});

  @override
  Widget build(BuildContext context) {
    final book = context.read<BookBloc>().state.book;

    /// TODO cut parts and put it in new functions
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
          child: SizedBox(
              width: double.infinity,
              // height: 200,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (book.read == true) {
                          await context.read<BookBloc>()
                              .bookService
                              .removeReadBook(
                              AddBookRequest(id: book.id!));
                        } else {
                          await context
                              .read<BookBloc>()
                              .bookService
                              .addReadBook(
                              AddBookRequest(id: book.id!));
                        }
                        if (!context.mounted) return;
                        context.read<BookBloc>().add(CreateInfoBookRequest(id: book.id!));
                        context.read<WatchedBooksHydratedBloc>().add(const GenerateBooksRequest());
                        showCustomSnackBar(
                            context: context,
                            color: Colors.green,
                            message: 'Le livre a bien été ${book.read == false ?'ajouté à': 'retiré de'} vos livres lus',
                            icon: Icons.check_circle_rounded);
                        //watch
                        Navigator.pop(context);
                      },
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: Row(children: [
                        const Icon(Icons.remove_red_eye, size: 30),
                        const SizedBox(
                          width: 10,
                        ), // Icons.visibility_off
                        Text(
                            book.read != null && book.read!
                                ? appL10n(context)!.remove_read
                                : appL10n(context)!.add_read,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500))
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (!context.mounted) return;
                          if (book.liked == true) {
                            await context
                                .read<BookBloc>()
                                .bookService
                                .removeLikedBook(
                                AddBookRequest(id: book.id!));
                          } else {
                            await context
                                .read<BookBloc>()
                                .bookService
                                .addLikedBook(
                                AddBookRequest(id: book.id!));
                            }
                          if (!context.mounted) return;
                          context.read<BookBloc>().add(
                              CreateInfoBookRequest(id: book.id!));
                          context.read<LikedBooksHydratedBloc>().add(
                              const GenerateBooksRequest());
                          showCustomSnackBar(
                              context: context,
                              color: Colors.green,
                              message: 'Le livre a bien été ${book.liked ==
                                  false
                                  ? 'ajouté à'
                                  : 'retiré de'} vos livres aimés',
                              icon: Icons.check_circle_rounded);
                          Navigator.pop(context);
                        },
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Row(children: [
                          const Icon(
                            Icons.favorite,
                            size: 30,
                          ), //
                          const SizedBox(
                            width: 10,
                          ), // IIcons.favorite_outlined
                          Text(
                              book.liked != null && book.liked!
                                  ? appL10n(context)!.dislike
                                  : appL10n(context)!.like,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500))
                        ])),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (book.wishlisted == true) {
                          await context
                              .read<BookBloc>()
                              .bookService
                              .removeWishListedBook(
                              AddBookRequest(id: book.id!));
                        } else {
                          await context
                              .read<BookBloc>()
                              .bookService
                              .addWishListedBook(
                              AddBookRequest(id: book.id!));
                        }
                        if (!context.mounted) return;
                        context
                            .read<BookBloc>()
                            .add(CreateInfoBookRequest(id: book.id!));
                        context.read<SavedBooksHydratedBloc>().add(const GenerateBooksRequest());
                        showCustomSnackBar(
                            context: context,
                            color: Colors.green,
                            message: 'Le livre a bien été ${book.wishlisted == false ?'ajouté à': 'retiré de'} vos livres en cours',
                            icon: Icons.check_circle_rounded);
                        Navigator.pop(context);
                      },
                      highlightColor: Colors.grey.withOpacity(0.1),
                      child: Row(children: [
                        const Icon(Icons.add_circle_outlined,
                            size: 30), // Icons.remove_circle
                        const SizedBox(
                          width: 10,
                        ), // I
                        Text(
                            book.wishlisted != null && book.wishlisted!
                                ? appL10n(context)!.remove_watchlist
                                : appL10n(context)!.add_watchlist,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500))
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () async {
                          if (book.disliked == false) {
                            await context
                                .read<BookBloc>()
                                .bookService
                                .addDislikedBook(
                                AddBookRequest(id: book.id!));
                          } else {
                            await context
                                .read<BookBloc>()
                                .bookService
                                .removeDislikedBook(
                                AddBookRequest(id: book.id!));
                          }
                          if (!context.mounted) return;
                          context.read<BookBloc>().add(CreateInfoBookRequest(id: book.id!));
                          context.read<LikedBooksHydratedBloc>().add(const GenerateBooksRequest());
                          showCustomSnackBar(
                              context: context,
                              color: Colors.green,
                              message: 'Le livre a bien été ${book.disliked == false ?'retiré de': 'restituer à'} vos prochaines recommandations.',
                              icon: Icons.check_circle_rounded);
                          Navigator.pop(context);
                        },
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Row(children: [
                          const Icon(
                            Icons.block_outlined,
                            size: 30,
                          ), // Icons.check_circle_rounded
                          const SizedBox(
                            width: 10,
                          ), // I
                          Text(
                              book.disliked != null && book.disliked!
                                  ? appL10n(context)!.interested
                                  : appL10n(context)!.not_interested,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500))
                        ]))
                  ]))),
    );
  }
}