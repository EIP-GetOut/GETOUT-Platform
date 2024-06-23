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
  literaryGenres,
  filmGenres,
  viewingPlatform,
  endForm,
  error
}

extension FormStatusX on FormStatus {
  // bool get isSocialMediaTime => this == FormStatus.socialMediaTime;
  // bool get isInterestChoices => this == FormStatus.interestChoices;
  bool get isLiteraryGenres => this == FormStatus.literaryGenres;
  bool get isFilmGenres => this == FormStatus.filmGenres;
  bool get isViewingPlatform => this == FormStatus.viewingPlatform;
  bool get isEndForm => this == FormStatus.endForm;
}

// FormState already exists in Flutter so FormStates is used instead
class FormStates extends Equatable {
  const FormStates({
    this.status = FormStatus.literaryGenres,
    // this.time = 0.0,
    /*this.interest = const {
      'Technologie' : false,
      'Sport' : false,
      'Musique' : false,
      'Voyage' : false,
      'Activité artistique' : false
    },*/
    this.literaryGenres = const {
      'Policier' : false,
      'Science-fiction' : false,
      'Politique' : false,
      'Poésie' : false,
      'Histoire' : false,
      'Science' : false,
      'Philosophie' : false,
      'Biographie' : false,
      'Contes et légendes' : false,
      'Romance' : false,
      'Autre genre' : false
    },
    this.filmGenres = const {
      'Action' : false,
      'Aventure' : false,
      'Animation' : false,
      'Comédie' : false,
      'Policier' : false,
      'Documentaire' : false,
      'Drame' : false,
      'Famille' : false,
      'Fantastique' : false,
      'Histoire' : false,
      'Horreur' : false,
      'Musique' : false,
      'Mystère' : false,
      'Romance' : false,
      'Science-fiction' : false,
      'Téléfilm' : false,
      'Thriller' : false,
      'Guerre' : false,
      'Western' : false,
      'Autre genre' : false
    },
    this.viewingPlatform = const {
      'Cinéma' : false,
      'DVD' : false,
      'VOD' : false,
      'Netflix' : false,
      'Prime Video' : false,
      'Disney+' : false,
      'Apple TV+' : false,
      'myCanal' : false,
      'Autre sources' : false
    },
  });
  final FormStatus status;
  // final double time;

  // final Map<String, bool> interest;
  final Map<String, bool> literaryGenres;
  final Map<String, bool> filmGenres;
  final Map<String, bool> viewingPlatform;

  @override
  List<Object?> get props => [status, literaryGenres, filmGenres, viewingPlatform]; // time, interest

  FormStates copyWith({
    FormStatus? status,
    // double? time,
    // Map<String, bool>? interest,
    Map<String, bool>? literaryGenres,
    Map<String, bool>? filmGenres,
    Map<String, bool>? viewingPlatform,
  }) {
    return FormStates(
      status: status ?? this.status,
      // time: time ?? this.time,
      // interest: interest ?? this.interest,
      literaryGenres: literaryGenres ?? this.literaryGenres,
      filmGenres: filmGenres ?? this.filmGenres,
      viewingPlatform: viewingPlatform ?? this.viewingPlatform,
    );
  }
}
