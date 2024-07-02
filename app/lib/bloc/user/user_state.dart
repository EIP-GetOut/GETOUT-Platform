/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Inès Maaroufi <ines.maaroufi@epitech.eu>
*/

part of 'user_bloc.dart';

enum Status {
  Fail,
  Success,
  Loading
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
  final List<int> booksGenres;
  final List<String> moviesGenres;


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

  Map<String, dynamic> toJson() {
    return {
      'isVerified': isVerified,
      'email': email,

      'firstName': firstName,
      'lastName': lastName,
      'bornDate': bornDate,
      'createdDate': createdDate,

      'spentMinutesReadinAndWatching': spentMinutesReadinAndWatching,
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

        spentMinutesReadinAndWatching: json['spentMinutesReadinAndWatching'],
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
  final String? cookiePath;
  final bool isCookieSet;

  //Account
  final Account? account;

  //other relative to phone/server accessibility
  final bool isOffline;
  final bool isServerDown;

  const UserState({
    this.cookiePath,
    bool? isCookieSet,

    this.account,

    bool? isOffline,
    bool? isServerDown,
  }) : isOffline = isOffline ?? true,
        isServerDown = isServerDown ?? false,
        isCookieSet = isCookieSet ?? false;

  @override
  List<Object?> get props => [cookiePath, isCookieSet, account, isOffline, isServerDown];

  UserState copyWith({
    String? cookiePath,
    bool? isCookieSet,

    Account? account,

    bool? isOffline,
    bool? isServerDown,}) {

    return UserState(
        cookiePath: cookiePath ?? this.cookiePath,
        isCookieSet: isCookieSet ?? this.isCookieSet,

        account: account ?? this.account,

        isOffline: isOffline ?? this.isOffline,
        isServerDown: isServerDown ?? this.isServerDown);
  }

  // Convert UserState to JSON
  Map<String, dynamic> toJson() {
    return {
      'cookie_path': cookiePath,
      'is_cookie_set': isCookieSet,

      'account': account?.toJson(),

      'is_offline': isOffline,
      'is_server_down': isServerDown,
    };
  }

  // Convert JSON to UserState
  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
        cookiePath: json['cookie_path'],
        isCookieSet: json['is_cookie_set'],
        isOffline: json['is_offline'],
        isServerDown: json['is_server_down']);
  }
}