/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

// ignore_for_file: avoid_print

// import 'package:GetOut/models/generate_movies_request.dart';
import 'package:GetOut/constants/movie_genre.dart';
import 'package:GetOut/models/requests/generate_movies.dart';
import 'package:GetOut/services/requests/requests_service.dart';

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
