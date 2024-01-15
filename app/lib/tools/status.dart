/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

enum Status { initial, success, error, loading, selected}

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isSelected => this == Status.selected;
}