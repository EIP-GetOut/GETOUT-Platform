import 'package:flutter_bloc/flutter_bloc.dart';

enum WelcomeEvent {
  startButtonPressed,
}

abstract class WelcomeState {}

class WelcomeInitialState extends WelcomeState {}

class WelcomeLoadedState extends WelcomeState {}

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState());

  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event == WelcomeEvent.startButtonPressed) {
      yield WelcomeLoadedState();
    }
  }
}
