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
      'Polar' : false,
      'Poésie' : false,
      'Thriller' : false,
      'Politique' : false,
      'Comédie' : false
    },
    this.filmGenres = const {
      'Action' : false,
      'Thriller' : false,
      'Western' : false,
      'Horreur' : false,
      'Comédie' : false
    },
    this.viewingPlatform = const {
      'Netflix' : false,
      'Prime Video' : false,
      'Disney +' : false,
      'Cinema' : false,
      'DVD' : false
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
