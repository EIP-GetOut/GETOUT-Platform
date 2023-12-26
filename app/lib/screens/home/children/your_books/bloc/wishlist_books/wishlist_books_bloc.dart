/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/bloc/home_repository.dart';

part 'wishlist_books_event.dart';
part 'wishlist_books_state.dart';

class WishlistBooksBloc extends Bloc<WishlistBooksEvent, WishlistBooksState> {

  WishlistBooksBloc({
    required this.homeRepository,
  }) : super(const WishlistBooksState()) {
    on<GetWishlistBooksRequest>(_mapGetWishlistBooksEventToState);
  }

  final HomeRepository homeRepository;

  void _mapGetWishlistBooksEventToState(
      GetWishlistBooksRequest event, Emitter<WishlistBooksState> emit) async {
    emit(state.copyWith(status: WishlistBookStatus.loading));
    try {
      final wishlistBooks = await homeRepository.getWishlistBooks(event);
      emit(
        state.copyWith(
          status: WishlistBookStatus.success,
          books: wishlistBooks,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: WishlistBookStatus.error));
    }
  }
}
