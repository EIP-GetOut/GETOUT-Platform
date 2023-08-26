/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/screens/book/pages/book.dart';
import 'package:getout/screens/home/widgets/books/books_error_widget.dart';
import 'package:getout/widgets/loading.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    Key? key,
  }) : super(key: key);

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
            return const BooksErrorWidget();
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
