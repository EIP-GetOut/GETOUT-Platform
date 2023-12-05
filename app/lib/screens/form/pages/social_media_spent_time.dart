import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/pages/areas_of_interest.dart';
import 'package:getout/screens/form/widgets/time_spent_social_media.dart';
import 'package:getout/screens/form/widgets/four_point.dart';

// Importez le bloc
import 'package:getout/screens/form/bloc/social_media_spent_time.dart';

class SocialMediaSpentTime extends StatelessWidget {
  const SocialMediaSpentTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialMediaSpentTimeBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VOS PRÉFÉRENCES'),
          leading: const BackButton(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 140),
              const PageIndicator(currentPage: 0, pageCount: 5),
              const SizedBox(height: 90),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'TEMPS PASSÉ SUR LES RÉSEAUX SOCIAUX PAR JOURS :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 30),
              // Utilisez BlocBuilder pour mettre Ã  jour la valeur du curseur
              BlocBuilder<SocialMediaSpentTimeBloc, double>(
                builder: (context, sliderValue) {
                  return SliderWidget(
                      minValue: 1.0,
                      maxValue: 12.0,
                      divisions: 11,
                      initialValue: sliderValue,
                      onChanged: (value) {
                        context
                            .read<SocialMediaSpentTimeBloc>()
                            .updateSliderValue(value);
                      });
                },
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 90 * MediaQuery.of(context).size.width / 100,
          height: 65,
          child: FloatingActionButton(
            child: Text('Suivant', style: Theme.of(context).textTheme.labelMedium),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AreasOfInterest()),
              );
            },
          ),
        ),
      ),
    );
  }
}
