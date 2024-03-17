/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SessionEvent extends Equatable {
  @override
  List<Object?> get props => [];
  const SessionEvent();
}

class ChangeEmailRequest extends SessionEvent {
  const ChangeEmailRequest({
    required this.password,
    required this.newEmail,
  });

  final String password;
  final String newEmail;
}

class ChangePasswordRequest extends SessionEvent {
  const ChangePasswordRequest({
    required this.password,
    required this.newPassword,
  });

  final String password;
  final String newPassword;
}

class DeleteAccountRequest extends SessionEvent {
  const DeleteAccountRequest({
    required this.password,
  });

  final String password;
}

class SetLanguageRequest extends SessionEvent {
  const SetLanguageRequest({
    required this.lang,
  });

  final String lang;
}

class SetThemeRequest extends SessionEvent {
  const SetThemeRequest({
    required this.theme,
  });

  final String theme;
}

class StatusResponse extends SessionEvent {
  const StatusResponse({required this.status, this.error});

  final Status status;
  final String? error;
}

class SessionService extends ServiceTemplate {
//  final String _id = (globals.session != null) ? globals.session!['id'].toString() : '';

  SessionService();

  Future<StatusResponse> changeEmail(ChangeEmailRequest changeEmailRequest) async {
    try { /// TODO we need to do something prettier
      ///
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}/account',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response?.statusCode != HttpStatus.ok) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while editing account email: ${response?.statusMessage}',
        ));
      }
    } on DioException catch (dioException) {
      if (dioException.response != null && dioException.response?.statusCode != null) {
        return Future.error(Exception(
          'Error ${dioException.response?.statusCode} while editing account email: ${dioException.response?.statusMessage}',
        ));
      }
      return Future.error(Exception(
          'Unknown error:  ${dioException.toString()}'));
    } catch (error) {
      return Future.error(Exception(
        'Unknown error: ${error.toString()}',
      ));
    }
    return const StatusResponse(status: Status.error);
  }

  Future<StatusResponse> changePassword(ChangePasswordRequest changePasswordRequest) async {
    return const StatusResponse(status: Status.error);
  }

  Future<StatusResponse> deleteAccount(DeleteAccountRequest deleteAccountRequest) async {
    return const StatusResponse(status: Status.error);
  }
  Future<StatusResponse> setLanguage(SetLanguageRequest setLanguageRequest) async {
    return const StatusResponse(status: Status.error);
  }
  Future<StatusResponse> setTheme(SetThemeRequest themeRequest) async {
    return const StatusResponse(status: Status.error);
  }

}
