import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/pages/literary_genre.dart';
import 'package:getout/screens/form/widgets/check_box_list_widget_interest_areas.dart';
import 'package:getout/screens/form/widgets/four_point.dart';

import 'package:getout/screens/form/bloc/areas_of_interest_bloc.dart';

class AreasOfInterest extends StatelessWidget {
  const AreasOfInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AreasOfInterestBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VOS PRÉFÉRENCES'),
          leading: const BackButton(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const PageIndicator(currentPage: 1, pageCount: 5),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'CENTRE D INTERET :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetInterestAreas(),
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
                          builder: (context) => const LiteraryGenre()),
                    );
                    context
                        .read<AreasOfInterestBloc>()
                        .add(AreasOfInterestNextButtonPressed());
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
