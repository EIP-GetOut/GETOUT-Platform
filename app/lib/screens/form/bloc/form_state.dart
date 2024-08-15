/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_bloc.dart';

enum FormStatus {
  // socialMediaTime,
  // interestChoices,
  bookGenres,
  movieGenres,
  viewingPlatform,
  endForm,
  error
}

extension FormStatusX on FormStatus {
  // bool get isSocialMediaTime => this == FormStatus.socialMediaTime;
  // bool get isInterestChoices => this == FormStatus.interestChoices;
  bool get isBookGenres => this == FormStatus.bookGenres;
  bool get isMovieGenres => this == FormStatus.movieGenres;
  bool get isViewingPlatform => this == FormStatus.viewingPlatform;
  bool get isEndForm => this == FormStatus.endForm;
  bool get isError => this == FormStatus.error;
}

// FormState already exists in Flutter so FormStates is used instead
class FormStates extends Equatable {
  const FormStates({
    this.status = FormStatus.bookGenres,
    // this.time = 0.0,
    /*this.interest = const {
      'Technologie' : false,
      'Sport' : false,
      'Musique' : false,
      'Voyage' : false,
      'Activité artistique' : false
    },*/
    this.bookGenres = const {
      'Policier': false,
      'Science-fiction': false,
      'Politique': false,
      'Poésie': false,
      'Histoire': false,
      'Science': false,
      'Philosophie': false,
      'Biographie': false,
      'Roman': false,
      'Suspence': false,
      'Autre genre': false
    },
    this.movieGenres = const {
      'Action': false,
      'Aventure': false,
      'Animation': false,
      'Comédie': false,
      'Policier': false,
      'Documentaire': false,
      'Drame': false,
      'Famille': false,
      'Fantastique': false,
      'Histoire': false,
      'Horreur': false,
      'Musique': false,
      'Mystère': false,
      'Romance': false,
      'Science-fiction': false,
      'Téléfilm': false,
      'Thriller': false,
      'Guerre': false,
      'Western': false,
      'Autre genre': false
    },
    this.viewingPlatform = const {
      'Cinéma': false,
      'DVD': false,
      'VOD': false,
      'Netflix': false,
      'Prime Video': false,
      'Disney+': false,
      'Apple TV+': false,
      'myCanal': false,
      'Autre sources': false
    },
  });
  final FormStatus status;
  // final double time;

  // final Map<String, bool> interest;
  final Map<String, bool> bookGenres;
  final Map<String, bool> movieGenres;
  final Map<String, bool> viewingPlatform;

  @override
  List<Object?> get props =>
      [status, bookGenres, movieGenres, viewingPlatform]; // time, interest

  FormStates copyWith({
    FormStatus? status,
    // double? time,
    // Map<String, bool>? interest,
    Map<String, bool>? bookGenres,
    Map<String, bool>? movieGenres,
    Map<String, bool>? viewingPlatform,
  }) {
    return FormStates(
      status: status ?? this.status,
      // time: time ?? this.time,
      // interest: interest ?? this.interest,
      bookGenres: bookGenres ?? this.bookGenres,
      movieGenres: movieGenres ?? this.movieGenres,
      viewingPlatform: viewingPlatform ?? this.viewingPlatform,
    );
  }
}
