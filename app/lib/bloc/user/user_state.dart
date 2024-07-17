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

class Preferences extends Equatable {
  final List<String> platforms;
  final List<String> booksGenres;
  final List<int> moviesGenres;


  const Preferences({
    required this.platforms,
    required this.booksGenres,
    required this.moviesGenres,
  });

  Preferences copyWith({
    List<String>? platforms,
    List<String>? booksGenres,
    List<int>? moviesGenres,
  }) {
    return Preferences(
        platforms: platforms ?? this.platforms,
        booksGenres: booksGenres ?? this.booksGenres,
        moviesGenres: moviesGenres ?? this.moviesGenres);
  }

  Map<String, dynamic> toJson() {
    return {
      'platforms': platforms,
      'booksGenres': booksGenres,
      'moviesGenres': moviesGenres
    };
  }

  factory Preferences.fromJson(Map<String, dynamic> json) {

    return Preferences(
        platforms: json['platforms'],
        booksGenres: json['booksGenres'],
        moviesGenres: json['moviesGenres']
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [platforms, booksGenres, moviesGenres];

}

class Account extends Equatable {
  //email
  final String id;
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
  final Preferences? preferences;

  const Account({
    required this.id,
    required this.isVerified,
    required this.email,

    required this.firstName,
    required this.lastName,
    required this.bornDate,
    required this.createdDate,

    required this.spentMinutesReadinAndWatching,
    this.minutesWatch = 0,
    this.pagesRead = 0,

    this.preferences,
  });

  Account copyWith({
    String? id,
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
    Preferences? preferences,
  }) {
    return Account(
        id: id ?? this.id,
        isVerified: isVerified ?? this.isVerified,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        bornDate: bornDate ?? this.bornDate,
        createdDate: createdDate ?? this.createdDate,
        spentMinutesReadinAndWatching: spentMinutesReadinAndWatching ?? this.spentMinutesReadinAndWatching,
        minutesWatch: minutesWatch ?? this.minutesWatch,
        pagesRead: pagesRead ?? this.pagesRead,
        preferences: preferences ?? this.preferences);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isVerified': isVerified,
      'email': email,

      'firstName': firstName,
      'lastName': lastName,
      'bornDate': bornDate,
      'createdDate': createdDate,

      'spentMinutesReadingAndWatching': spentMinutesReadinAndWatching,
      'minutesWatch': minutesWatch,
      'pagesRead': pagesRead,
      'preferences': preferences?.toJson(),
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
        id: json['id'],
        isVerified: json['isVerified'],
        email: json['email'],

        firstName: json['firstName'],
        lastName: json['lastName'],
        bornDate: json['bornDate'],
        createdDate: json['createdDate'],

        spentMinutesReadinAndWatching: json['spentMinutesReadingAndWatching'],
        minutesWatch: json['minutesWatch'],
        pagesRead: json['pagesRead'],
        preferences: Preferences.fromJson(json['preferences'])
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isVerified, email, firstName, lastName,
    bornDate, createdDate, spentMinutesReadinAndWatching];
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
    return {
      'cookiePath': cookiePath,
      'isCookieSet': isCookieSet,
      'account': account?.toJson(),
      'status': status.index,
    };
  }

  // Convert JSON to UserState
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
        cookiePath: json['cookiePath'],
        isCookieSet: json['isCookieSet'],
        account: Account.fromJson(json['account']),
        status: Status.values[json['status']]);
  }
}