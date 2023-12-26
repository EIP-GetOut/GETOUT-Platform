/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/children/dashboard/widgets/books/books_succes_widget.dart';
import 'package:getout/screens/home/children/dashboard/widgets/books/books_error_widget.dart';
import 'package:getout/screens/home/children/dashboard/bloc/books/books_bloc.dart';

class ListPreviewWidget extends StatelessWidget {
  const ListPreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksBloc, BooksState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return BooksSuccessWidget(books: state.books);
        } else {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(0, 255, 5, 5),
            ));
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
