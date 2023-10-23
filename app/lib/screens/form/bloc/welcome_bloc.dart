import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/bloc/social_media_spent_time.dart';

enum WelcomeEvent {
  startButtonPressed,
}

abstract class WelcomeState {}

class WelcomeInitialState extends WelcomeState {}

class WelcomeLoadedState extends WelcomeState {}

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState());

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event == WelcomeEvent.startButtonPressed) {
      yield WelcomeLoadedState();
    }
  }
}
