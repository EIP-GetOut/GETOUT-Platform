/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/bloc/recommended_books/recommended_books_bloc.dart';
import 'package:getout/screens/home/widgets/recommended_books/recommended_books_success_widget.dart';
import 'package:getout/tools/status.dart';
import 'package:getout/widgets/object_loading_error_widget.dart';

class RecommendedBooksWidget extends StatelessWidget {
  const RecommendedBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedBooksBloc, RecommendedBooksState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return RecommendedBooksSuccessWidget(books: state.recommendedBooks);
        } else {
          if (state.status.isLoading) {
            return const Center(
                child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(0, 255, 5, 5))));
          } else if (state.status.isError) {
//            return const MoviesErrorWidget();
            return const ObjectLoadingErrorWidget(object: 'les films');
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
