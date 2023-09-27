/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Writed by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:getout/screens/book/bloc/book_service.dart';
import 'package:getout/screens/book/bloc/book_bloc.dart';

class BookRepository {
  const BookRepository({
    required this.service,
  });
  final BookService service;

  Future<InfoBookResponse> getInfoBook(CreateInfoBookRequest request) async =>
      service.getInfoBook(request);
}
