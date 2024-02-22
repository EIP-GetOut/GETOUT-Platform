/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

import 'package:equatable/equatable.dart';

import 'package:getout/tools/status.dart';
import 'package:getout/screens/home/bloc/Movies/Movies_event.dart';

//todo make every movies bloc use this state.
class ListMoviesState extends Equatable {
  const ListMoviesState({
    this.status = Status.initial,
    List<MoviePreview>? listMovies,
  }) : listMovies = listMovies ?? const [];

  final List<MoviePreview> listMovies;
  final Status status;

  @override
  List<Object?> get props => [status, listMovies];

  ListMoviesState copyWith({
    List<MoviePreview>? listMovies,
    Status? status,
  }) {
    return ListMoviesState(
      listMovies: listMovies,
      status: status ?? this.status,
    );
  }

  factory ListMoviesState.fromMap(Map<String, dynamic> map) {
    List<MoviePreview> movies = [];

    map['recommended']!.forEach((element) => {
          movies.add(MoviePreview(
              id: element['id'],
              title: element['title'],
              posterPath: element['posterPath'],
              overview: element['overview']))
        });
    return ListMoviesState(
        listMovies: movies,
        status: stringToStatus[map['status']] ?? Status.error);
  }

  Map<String, dynamic> toMap() {
    return {
      'recommended': listMovies
          .map((movie) => {
                'id': movie.id,
                'title': movie.title,
                'posterPath': movie.posterPath,
                'overview': movie.overview,
              })
          .toList(),
      'status': statusToString[status],
    };
  }
}
