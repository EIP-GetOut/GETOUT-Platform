/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

part of 'form_bloc.dart';

enum FormStatus {
  socialMediaTime,
  interestChoices,
  literaryGenres,
  filmGenres,
  viewingPlatform,
  endForm,
  error
}

extension FormStatusX on FormStatus {
  bool get isSocialMediaTime => this == FormStatus.socialMediaTime;
  bool get isInterestChoices => this == FormStatus.interestChoices;
  bool get isLiteraryGenres => this == FormStatus.literaryGenres;
  bool get isFilmGenres => this == FormStatus.filmGenres;
  bool get isViewingPlatform => this == FormStatus.viewingPlatform;
  bool get isEndForm => this == FormStatus.endForm;
}

// FormState already exists in Flutter so FormStates is used instead
class FormStates extends Equatable {
  const FormStates({
    this.status = FormStatus.socialMediaTime,
    this.time = 0.0,
    this.interest = const [false, false, false, false, false],
    this.literaryGenres = const [false, false, false, false, false],
    this.filmGenres = const [false, false, false, false, false],
    this.viewingPlatform = const [false, false, false, false, false],
  });
  final FormStatus status;
  final double time;
  final List<bool> interest;
  final List<bool> literaryGenres;
  final List<bool> filmGenres;
  final List<bool> viewingPlatform;

  @override
  List<Object?> get props => [status, time, interest, literaryGenres, filmGenres, viewingPlatform];

  FormStates copyWith({
    FormStatus? status,
    double? time,
    List<bool>? interest,
    List<bool>? literaryGenres,
    List<bool>? filmGenres,
    List<bool>? viewingPlatform,
  }) {
    return FormStates(
      status: status ?? this.status,
      time: time ?? this.time,
      interest: interest ?? this.interest,
      literaryGenres: literaryGenres ?? this.literaryGenres,
      filmGenres: filmGenres ?? this.filmGenres,
      viewingPlatform: viewingPlatform ?? this.viewingPlatform,
    );
  }
}
