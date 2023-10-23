import 'package:flutter_bloc/flutter_bloc.dart';

class StreamingPlatformBloc
    extends Bloc<StreamingPlatformEvent, StreamingPlatformState> {
  StreamingPlatformBloc() : super(StreamingPlatformInitialState());

  @override
  Stream<StreamingPlatformState> mapEventToState(
      StreamingPlatformEvent event) async* {
    if (event is StreamingPlatformNextButtonPressed) {
      yield StreamingPlatformLoadedState();
    }
  }
}

// Définissez les événements nécessaires
abstract class StreamingPlatformEvent {}

class StreamingPlatformNextButtonPressed extends StreamingPlatformEvent {}

// Définissez les états nécessaires
abstract class StreamingPlatformState {}

class StreamingPlatformInitialState extends StreamingPlatformState {}

class StreamingPlatformLoadedState extends StreamingPlatformState {}
