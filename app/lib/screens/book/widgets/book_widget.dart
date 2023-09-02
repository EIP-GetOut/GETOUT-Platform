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
        return state.status.isSuccess
            ? BookSuccessWidget(
                book: state.book,
              )
            : state.status.isLoading
                ? const Center(
                    child: LoadingPage(),
                  )
                : state.status.isError
                    ? const BooksErrorWidget()
                    : const SizedBox();
      },
    );
  }
}
