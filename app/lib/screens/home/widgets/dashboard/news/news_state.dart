/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/
part of 'news_bloc.dart';

enum NewsStatus { initial, success, error, loading }

extension NewsStatusX on NewsStatus {
  bool get isInitial => this == NewsStatus.initial;
  bool get isSuccess => this == NewsStatus.success;
  bool get isError => this == NewsStatus.error;
  bool get isLoading => this == NewsStatus.loading;
}

class NewsState extends Equatable {
  const NewsState({
    this.status = NewsStatus.initial,
    NewsResponse? news,
  }) : news = news ?? const NewsResponse(statusCode: 200);

  final NewsResponse news;
  final NewsStatus status;

  @override
  List<Object?> get props => [status, news];

  NewsState copyWith({
    NewsResponse? news,
    NewsStatus? status,
  }) {
    return NewsState(
      news: news ?? this.news,
      status: status ?? this.status,
    );
  }
}
