/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/home/children/your_books/bloc/wishlist_books/wishlist_books_bloc.dart';
import 'package:getout/screens/home/children/your_books/widgets/wishlist_books/wishlist_books_success_widget.dart';
import 'package:getout/screens/home/children/your_books/widgets/wishlist_books/wishlist_books_error_widget.dart';

class WishlistBooksWidget extends StatelessWidget {
  const WishlistBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBooksBloc, WishlistBooksState>(
      builder: (context, state) {
        if (state.status.isSuccess) {
          return WishlistBooksSuccessWidget(books: state.books);
        } else {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator(
              backgroundColor: Color.fromARGB(0, 255, 5, 5),
            ));
          } else if (state.status.isError) {
            return const WishlistBooksErrorWidget();
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
