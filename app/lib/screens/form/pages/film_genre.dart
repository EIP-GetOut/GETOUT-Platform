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
        body: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 140),
              PageIndicator(currentPage: 3, pageCount: 5),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'GENRES CINÉMATOGRAPHIQUES :',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              CheckboxListWidgetFilmGenre(),
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
                      builder: (context) => const StreamingPlatform()),
                );
                context.read<FilmGenreBloc>();
              },
            ),
          )

      ),
    );
  }
}
