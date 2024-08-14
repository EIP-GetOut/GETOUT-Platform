/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'story_news_bloc.dart';

class StoryNewsEvent extends Equatable {
  const StoryNewsEvent();

  @override
  List<Object?> get props => [];
}

class StoryNewsRequest extends StoryNewsEvent {
  const StoryNewsRequest();
}

class StoryNewsResponse extends StoryNewsEvent {
  const StoryNewsResponse(
      {this.quote,
      this.author,
      this.sourceUrl,
      this.sourceStr,
      required this.statusCode});

  final int statusCode;
  final String? quote;
  final String? author;
  final String? sourceUrl;
  final String? sourceStr;
}

class AddStoryNewsResponse extends StoryNewsEvent {
  final int statusCode;

  const AddStoryNewsResponse({required this.statusCode});
}
