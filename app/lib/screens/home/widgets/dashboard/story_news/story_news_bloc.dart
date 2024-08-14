/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:getout/screens/home/services/service.dart';

part 'story_news_event.dart';
part 'story_news_state.dart';

class StoryNewsBloc extends Bloc<StoryNewsEvent, StoryNewsState> {
  final HomeService homeService;

  StoryNewsBloc({
    required this.homeService,
  }) : super(const StoryNewsState()) {
    on<StoryNewsRequest>(_mapGetStoryNewsEventToState);
  }


  void _mapGetStoryNewsEventToState(
      StoryNewsRequest event, Emitter<StoryNewsState> emit) async {
    emit(state.copyWith(status: StoryNewsStatus.loading));
    try {
      final StoryNewsResponse storyNews = await homeService.getInfoStoryNews();
      emit(
        state.copyWith(
          status: StoryNewsStatus.success,
          storyNews: storyNews,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: StoryNewsStatus.error));
    }
  }
}
