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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('VOS PRÉFÉRENCES'.padRight(
              '             '.length,
              String.fromCharCodes([0x00A0 /*No-Break Space*/ ])), // don't know but print white space,
              style: Theme.of(context).textTheme.titleLarge),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const PageIndicator(currentPage: 0, pageCount: 5),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'TEMPS PASSE SUR LES RESEAUX SOCIAUX PAR JOURS :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
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
              const SizedBox(height: 20),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: Text('Suivant',
                      style: Theme.of(context).textTheme.bodyLarge),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AreasOfInterest()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
