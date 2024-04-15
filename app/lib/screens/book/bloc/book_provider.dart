/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:getout/screens/book/bloc/book_bloc.dart';
import 'package:getout/screens/book/bloc/book_service.dart';
import 'package:getout/screens/book/widgets/book_widget.dart';

class Book extends StatelessWidget {
  const Book(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RepositoryProvider(
        create: (context) => BookService(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<BookBloc>(
              create: (context) => BookBloc(
                bookService: context.read<BookService>(),
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
