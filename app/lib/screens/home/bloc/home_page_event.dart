part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}


class HomePageToIdx extends HomePageEvent {
  const HomePageToIdx(this.idx);

  final int idx;

  @override
  List<Object> get props => [idx];
}