import 'package:flutter_bloc/flutter_bloc.dart';

class SocialMediaSpentTimeBloc extends Cubit<double> {
  SocialMediaSpentTimeBloc() : super(1.0);

  void updateSliderValue(double value) => emit(value);
}
