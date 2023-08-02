/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

// ignore_for_file: avoid_print

// import 'package:getout/models/generate_movies_request.dart';
import 'package:getout/constants/movie_genre.dart';
// import 'package:getout/models/home/generate_movies.dart';
import 'package:getout/services/requests/requests_service.dart';
import 'package:getout/screens/home/bloc/movie_bloc.dart';

// include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate

void main() async {
  GenerateMoviesRequest request =
      GenerateMoviesRequest(genres: [MovieGenre.ACTION, MovieGenre.FANTASY]);

  await RequestsService.instance
      .generateMovies(request)
      .then((GenerateMoviesResponse response) {
    for (var moviePreview in response) {
      print('${moviePreview.id} ${moviePreview.title}');
    }
  });

  // print(await http.read(Uri.https('example.com', 'foobar.txt')));
}
