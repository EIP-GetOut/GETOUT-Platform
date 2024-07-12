/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

enum Status {
  initial,
  success,
  error,
  loading,
  selected,
  isNotFound,
  isFound,
  isFoundWithoutPreferences,
  emailNotVerified
}
final Map<Status, String> statusToString = {
  Status.initial: 'initial',
  Status.success: 'success',
  Status.error: 'error',
  Status.loading: 'loading',
  Status.selected: 'selected',
  Status.isNotFound: 'isNotFound',
  Status.isFound: 'isFound',
  Status.isFoundWithoutPreferences: 'isFoundWithoutPreferences',
  Status.emailNotVerified: 'emailNotVerified',
};

final Map<String, Status> stringToStatus = statusToString.map((key, value) => MapEntry(value, key));

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isSelected => this == Status.selected;
  bool get isNotFound => this == Status.isNotFound;
  bool get isFound => this == Status.isFound;
  bool get isFoundWithoutPreferences => this == Status.isFoundWithoutPreferences;
  bool get emailNotVerified => this == Status.emailNotVerified;
}
