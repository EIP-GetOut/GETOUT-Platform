/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Theo Boysson <theo.boysson@epitech.eu>
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getout/screens/form/bloc/film_genre_bloc.dart';
import 'package:getout/screens/form/pages/streaming_platform.dart';
import 'package:getout/screens/form/widgets/check_box_film_genre.dart';
import 'package:getout/screens/form/widgets/four_point.dart';

class FilmGenre extends StatelessWidget {
  const FilmGenre({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmGenreBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('VOS PRÉFÉRENCES'),
          leading: const BackButton(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const PageIndicator(currentPage: 3, pageCount: 5),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'GENRE CINEMATOGRAPHIQUE PREFERE :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const CheckboxListWidgetFilmGenre(),
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
                          builder: (context) => const StreamingPlatform()),
                    );
                    context.read<FilmGenreBloc>();
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
