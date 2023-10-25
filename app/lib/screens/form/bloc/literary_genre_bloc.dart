import 'package:flutter_bloc/flutter_bloc.dart';

class LiteraryGenreBloc extends Bloc<LiteraryGenreEvent, LiteraryGenreState> {
  LiteraryGenreBloc() : super(LiteraryGenreInitialState());

  Stream<LiteraryGenreState> mapEventToState(LiteraryGenreEvent event) async* {
    if (event is LiteraryGenreNextButtonPressed) {
      yield LiteraryGenreLoadedState();
    }
  }
}

// Définissez les événements nécessaires
abstract class LiteraryGenreEvent {}

class LiteraryGenreNextButtonPressed extends LiteraryGenreEvent {}

// Définissez les états nécessaires
abstract class LiteraryGenreState {}

class LiteraryGenreInitialState extends LiteraryGenreState {}

class LiteraryGenreLoadedState extends LiteraryGenreState {}
