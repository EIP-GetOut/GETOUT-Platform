/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'news_bloc.dart';

class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class NewsRequest extends NewsEvent {
  const NewsRequest();
}

class NewsResponse extends NewsEvent {
  const NewsResponse(
      {this.title,
      this.picture,
      this.url,
      this.sourceLogo,
      required this.statusCode});

  final int statusCode;
  final String? title;
  final String? picture;
  final String? url;
  final String? sourceLogo;
}

class AddNewsResponse extends NewsEvent {
  final int statusCode;

  const AddNewsResponse({required this.statusCode});
}
