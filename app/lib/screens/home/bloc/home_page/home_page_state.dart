/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  const HomePageState({
    this.idx = 0,
  });

  final int idx;

  HomePageState copyWith({
    int? idx,
  }) {
    return HomePageState(
      idx: idx ?? this.idx,
    );
  }

  @override
  List<Object> get props => [idx];
}