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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('VOS PREFERENCES',
              style: Theme.of(context).textTheme.titleSmall),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const PageIndicator(currentPage: 2, pageCount: 5),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'GENRE LITTERAIRE PREFERE :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetLiteraryGenre(),
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
                          builder: (context) => const FilmGenre()),
                    );
                    context.read<LiteraryGenre>();
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
