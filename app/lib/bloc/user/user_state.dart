/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'user_bloc.dart';

enum Status {
  Logout,
  Login,
  LoginWithPrefs,
//  Loading,
}

class Account extends Equatable {
  //email
  final bool isVerified;
  final String email;
  //info
  final String firstName;
  final String lastName;
  final String bornDate;
  final String createdDate;
  //stats
  final int spentMinutesReadinAndWatching;
  final int minutesWatch; //todo
  final int pagesRead; //todo
  //pref
  final List<String> platforms;
  final List<String> booksGenres;
  final List<int> moviesGenres;

  const Account({
    required this.isVerified,
    required this.email,

    required this.firstName,
    required this.lastName,
    required this.bornDate,
    required this.createdDate,

    required this.spentMinutesReadinAndWatching,
    this.minutesWatch = 0,
    this.pagesRead = 0,

    required this.platforms,
    required this.booksGenres,
    required this.moviesGenres,
  });

  Account copyWith({
    bool? isVerified,
    String? email,
    String? firstName,
    String? lastName,
    String? bornDate,
    String? createdDate,
    int? spentMinutesReadinAndWatching,
    int? minutesWatch,
    int? pagesRead,
    List<String>? platforms,
    List<String>? booksGenres,
    List<int>? moviesGenres,
  }) {
    return Account(
        isVerified: isVerified ?? this.isVerified,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        bornDate: bornDate ?? this.bornDate,
        createdDate: createdDate ?? this.createdDate,
        spentMinutesReadinAndWatching: spentMinutesReadinAndWatching ?? this.spentMinutesReadinAndWatching,
        minutesWatch: minutesWatch ?? this.minutesWatch,
        pagesRead: pagesRead ?? this.pagesRead,
        platforms: platforms ?? this.platforms,
        booksGenres: booksGenres ?? this.booksGenres,
        moviesGenres: moviesGenres ?? this.moviesGenres);
  }

  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'email': email,

      'firstName': firstName,
      'lastName': lastName,
      'bornDate': bornDate,
      'createdDate': createdDate,

      'spentMinutesReadingAndWatching': spentMinutesReadinAndWatching,
      'minutesWatch': minutesWatch,
      'pagesRead': pagesRead,

      'platforms': platforms,
      'booksGenres': booksGenres,
      'moviesGenres': moviesGenres
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        isVerified: json['isVerified'],
        email: json['email'],

        firstName: json['firstName'],
        lastName: json['lastName'],
        bornDate: json['bornDate'],
        createdDate: json['createdDate'],

        spentMinutesReadinAndWatching: json['spentMinutesReadingAndWatching'],
        minutesWatch: json['minutesWatch'],
        pagesRead: json['pagesRead'],
        platforms: json['platforms'],
        booksGenres: json['booksGenres'],
        moviesGenres: json['moviesGenres']
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isVerified, email, firstName, lastName,
    bornDate, createdDate, spentMinutesReadinAndWatching,
    platforms, booksGenres, moviesGenres];
}

class UserState extends Equatable {
  //cookie
  final String cookiePath;
  final bool isCookieSet;

  //Account
  final Account? account;

  final Status status;

  const UserState({
    required this.cookiePath,
    bool? isCookieSet,

    this.account,

    this.status = Status.Logout,
  }) : isCookieSet = isCookieSet ?? false;

  @override
  List<Object?> get props => [cookiePath, isCookieSet, account, status];

  UserState copyWith({
    String? cookiePath,
    bool? isCookieSet,

    Account? account,

    Status? status}) {

    return UserState(
        cookiePath: cookiePath ?? this.cookiePath,
        isCookieSet: isCookieSet ?? this.isCookieSet,

        account: account ?? this.account,

        status: status ?? this.status);
  }

  // Convert UserState to JSON
  Map<String, dynamic> toJson() {
    print('> $status, ${status.index}');
    return {
      'cookiePath': cookiePath,
      'isCookieSet': isCookieSet,
      'account': account?.toJson(),
      'status': status.index,
    };
  }

  // Convert JSON to UserState
  factory UserState.fromJson(Map<String, dynamic> json) {
    print('< ${json['status']}, ${Status.values[json['status']]}');
    return UserState(
        cookiePath: json['cookiePath'],
        isCookieSet: json['isCookieSet'],
        account: Account.fromJson(json['account']),
        status: Status.values[json['status']]);
  }
}