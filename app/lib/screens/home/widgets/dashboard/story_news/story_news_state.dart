/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'story_news_bloc.dart';

enum StoryNewsStatus { initial, success, error, loading }

extension StoryNewsStatusX on StoryNewsStatus {
  bool get isInitial => this == StoryNewsStatus.initial;
  bool get isSuccess => this == StoryNewsStatus.success;
  bool get isError => this == StoryNewsStatus.error;
  bool get isLoading => this == StoryNewsStatus.loading;
}

class StoryNewsState extends Equatable {
  const StoryNewsState({
    this.status = StoryNewsStatus.initial,
    StoryNewsResponse? storyNews,
  }) : storyNews = storyNews ?? const StoryNewsResponse(statusCode: 200);

  final StoryNewsResponse storyNews;
  final StoryNewsStatus status;

  @override
  List<Object?> get props => [status, storyNews];

  StoryNewsState copyWith({
    StoryNewsResponse? storyNews,
    StoryNewsStatus? status,
  }) {
    return StoryNewsState(
      storyNews: storyNews ?? this.storyNews,
      status: status ?? this.status,
    );
  }
}
