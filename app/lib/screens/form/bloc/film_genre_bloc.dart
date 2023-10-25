import 'package:flutter_bloc/flutter_bloc.dart';

class FilmGenreBloc extends Bloc<FilmGenreEvent, FilmGenreState> {
  FilmGenreBloc() : super(FilmGenreInitialState());

  Stream<FilmGenreState> mapEventToState(FilmGenreEvent event) async* {
    if (event is FilmGenreNextButtonPressed) {
      yield FilmGenreLoadedState();
    }
  }
}

// Définissez les événements nécessaires
abstract class FilmGenreEvent {}

class FilmGenreNextButtonPressed extends FilmGenreEvent {}

// Définissez les états nécessaires
abstract class FilmGenreState {}

class FilmGenreInitialState extends FilmGenreState {}

class FilmGenreLoadedState extends FilmGenreState {}
