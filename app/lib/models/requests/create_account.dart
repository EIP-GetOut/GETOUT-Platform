/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

class CreateAccountRequest {
    int id;
    String email;
    String password;
    String firstName;
    String lastName;
    String bornDate;
    String salt;

  CreateAccountRequest({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.bornDate,
    required this.salt
  });
}

class AccountCreated {
  int id;
  String email;
  String password;
  String firstName;
  String lastName;
  String bornDate;
  String salt;

  AccountCreated(
      {required this.id, required this.email, required this.password, required this.firstName, required this.lastName, required this.bornDate, required this.salt});
}

typedef CreateAccountResponse = AccountCreated;