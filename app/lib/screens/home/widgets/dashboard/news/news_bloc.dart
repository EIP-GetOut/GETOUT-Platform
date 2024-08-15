/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/services/service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final HomeService homeService;

  NewsBloc({
    required this.homeService,
  }) : super(const NewsState()) {
    on<NewsRequest>(_mapGetNewsEventToState);
  }


  void _mapGetNewsEventToState(
      NewsRequest event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: NewsStatus.loading));
    try {
      final NewsResponse news = await homeService.getInfoNews();
      emit(
        state.copyWith(
          status: NewsStatus.success,
          news: news,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: NewsStatus.error));
    }
  }
}
