/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/screens/book/pages/book.dart';
import 'package:getout/tools/app_l10n.dart';
import 'package:getout/widgets/loading.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookBloc, BookState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return BookSuccessWidget(book: state.book);
        } else {
          if (state.status.isLoading) {
            return const Center(child: LoadingPage());
          } else if (state.status.isError) {
            return ObjectLoadingErrorWidget(object: appL10n(context)!.the_book.toLowerCase());
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}