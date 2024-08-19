/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Alexandre Chetrit <chetrit.pro@hotmail.com>
*/

/*{
  platforms:[
    Cinéma, DVD, VOD, Netflix, Prime Video, Disney+, Apple TV+, myCanal, Autre sources
  ],
  booksGenres: [
    crime, fiction, political, null, history, science, philosophy, biography, tale, romance, TODO
  ],
  moviesGenres: [
    28, 12, 16, 35, 80, 99, 18, 10751, 14, 36, 27, 10402, 9648, 10749, 878, 10770, 53, 10752, 37, 0
  ]
}*/

const Map<String, int> MovieGenreList = {
  'Action': 28,
  'Aventure': 12,
  'Animation': 16,
  'Comédie': 35,
  'Policier': 80,
  'Documentaire': 99,
  'Drame': 18,
  'Famille': 10751,
  'Fantastique': 14,
  'Histoire': 36,
  'Horreur': 27,
  'Musique': 10402,
  'Mystère': 9648,
  'Romance': 10749,
  'Science-fiction': 878,
  'Téléfilm': 10770,
  'Thriller': 53,
  'Guerre': 10752,
  'Western': 37,
  'Autre genre': 0
};

const Map<String, String> BookGenreList = {
  'Policier': 'crime',
  'Science-fiction': 'fiction',
  'Politique': 'political',
  'Poésie': 'poetry',
  'Histoire': 'history',
  'Science': 'science',
  'Philosophie': 'philosophy',
  'Biographie': 'biography',
  // 'Contes et légendes' : 'tale',
  'Roman': 'novel',
  // 'Romance' : 'romance',
  'Suspence': 'suspence',
  'Autre genre': 'TODO'
};
