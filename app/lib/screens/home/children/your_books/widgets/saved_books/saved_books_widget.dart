/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/saved_books/saved_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/widgets/saved_books/saved_books_success_widget.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';

class SavedBooksWidget extends StatelessWidget {
  const SavedBooksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedBooksHydratedBloc, SavedBooksState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return SavedBooksSuccessWidget(books: state.savedBooks);
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
