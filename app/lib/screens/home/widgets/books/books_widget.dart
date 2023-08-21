/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/widgets/load_circle.dart';

import 'package:getout/screens/home/widgets/books/books.dart';
import 'package:getout/screens/home/widgets/books/books_error_widget.dart';

import 'package:getout/screens/home/bloc/books/books_bloc.dart';

class BooksWidget extends StatelessWidget {
  const BooksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        return state.status.isSuccess
            ? BooksSuccessWidget(
                books: state.books,
              )
            : state.status.isLoading
                ? const Padding(
                    padding: EdgeInsets.only(
                        bottom: 100), //apply padding to all four sides
                    child: Center(child: LoadCirclePage()))
                : state.status.isError
                    ? const BooksErrorWidget()
                    : const SizedBox();
      },
    );
  }
}
