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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 140),
              const PageIndicator(currentPage: 1, pageCount: 5),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'CENTRE D\'INTERÊT :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetInterestAreas(),
            ],
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
                      builder: (context) => const LiteraryGenre()),
                );
                context.read<AreasOfInterestBloc>().add(AreasOfInterestNextButtonPressed());
              },
            ),
          )
      ),
    );
  }
}
