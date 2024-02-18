/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

enum Status { initial, success, error, loading, selected, is_not_found, is_found}

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isSelected => this == Status.selected;
  bool get isNotFound => this == Status.is_not_found;
  bool get isFound => this == Status.is_found;
}
