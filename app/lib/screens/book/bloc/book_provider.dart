import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/screens/book/bloc/book_service.dart';
import 'package:getout/screens/book/bloc/book_repository.dart';
import 'package:getout/screens/book/widgets/book_widget.dart';

class Book extends StatelessWidget {
  const Book(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => BookRepository(service: BookService()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<BookBloc>(
              create: (context) => BookBloc(
                bookRepository: context.read<BookRepository>(),
              )..add(
                  CreateInfoBookRequest(id: id),
                ),
            ),
          ],
          child: const BookWidget(),
        ),
      ),
    );
  }
}
