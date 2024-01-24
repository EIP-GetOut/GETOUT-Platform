import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/bloc/literary_genre_bloc.dart';
import 'package:getout/screens/form/pages/film_genre.dart';
import 'package:getout/screens/form/widgets/check_box_literary_genre.dart';
import 'package:getout/screens/form/widgets/four_point.dart';

class LiteraryGenre extends StatelessWidget {
  const LiteraryGenre({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LiteraryGenreBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VOS PRÉFÉRENCES'),
          leading: const BackButton(),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 140),
              const PageIndicator(currentPage: 2, pageCount: 5),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'GENRES LITTÉRAIRES :',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetLiteraryGenre(),
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
                      builder: (context) => const FilmGenre()),
                );
                context.read<LiteraryGenre>();
              },
            ),
          )

      ),
    );
  }
}
