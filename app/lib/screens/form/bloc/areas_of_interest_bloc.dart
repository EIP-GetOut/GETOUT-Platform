import 'package:flutter_bloc/flutter_bloc.dart';

class AreasOfInterestBloc
    extends Bloc<AreasOfInterestEvent, AreasOfInterestState> {
  AreasOfInterestBloc() : super(AreasOfInterestInitialState());

  Stream<AreasOfInterestState> mapEventToState(
      AreasOfInterestEvent event) async* {
    if (event is AreasOfInterestNextButtonPressed) {
      yield AreasOfInterestLoadedState();
    }
  }
}

// Définissez les événements nécessaires
abstract class AreasOfInterestEvent {}

class AreasOfInterestNextButtonPressed extends AreasOfInterestEvent {}

// Définissez les états nécessaires
abstract class AreasOfInterestState {}

class AreasOfInterestInitialState extends AreasOfInterestState {}

class AreasOfInterestLoadedState extends AreasOfInterestState {}
