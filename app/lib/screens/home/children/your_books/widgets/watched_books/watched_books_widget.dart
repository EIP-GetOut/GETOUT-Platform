/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/watched_books/watched_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/widgets/watched_books/watched_books_success_widget.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';

class WatchedBooksWidget extends StatelessWidget {
  const WatchedBooksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchedBooksHydratedBloc, WatchedBooksState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return WatchedBooksSuccessWidget(books: state.watchedBooks);
        } else {
          if (state.status.isLoading) {
            return const Center(child: Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(0, 255, 5, 5))));

          } else if (state.status.isError) {
            return ObjectLoadingErrorWidget(object: appL10n(context)!.saved_books);
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
