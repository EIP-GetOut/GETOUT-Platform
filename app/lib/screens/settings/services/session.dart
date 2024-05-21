/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class SessionService extends ServiceTemplate {
//  final String _id = (globals.session != null) ? globals.session!['id'].toString() : '';

  SessionService();

  Future<StatusResponse> changeEmail(String password, String newEmail) async {
    try {
      /// TODO we need to do something prettier
      ///
      final response = await globals.dio?.delete(
          '${ApiConstants.rootApiPath}/account',
          options: Options(headers: {'Content-Type': 'application/json'}));

      if (response?.statusCode != HttpStatus.OK) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while editing account email: ${response?.statusMessage}',
        ));
      }
    } on DioException catch (dioException) {
      if (dioException.response != null &&
          dioException.response?.statusCode != null) {
        return Future.error(Exception(
          'Error ${dioException.response?.statusCode} while editing account email: ${dioException.response?.statusMessage}',
        ));
      }
      return Future.error(
          Exception('Unknown error:  ${dioException.toString()}'));
    } catch (error) {
      return Future.error(Exception(
        'Unknown error: ${error.toString()}',
      ));
    }
    return const StatusResponse();
  }

  Future<StatusResponse> changePassword(
      String password, String newPassword) async {
    return const StatusResponse();
  }

  Future<StatusResponse> disconnect() async {
    try {
      final response = await globals.dio?.post(
        '${ApiConstants.rootApiPath}${ApiConstants.accountPath}/logout',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.NO_CONTENT) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while editing account email: ${response?.statusMessage}',
        ));
      }
      await globals.sessionManager.getSession();
      return const StatusResponse(status: 200);
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<StatusResponse> deleteAccount() async {
    try {
      final response = await globals.dio?.delete(
        '${ApiConstants.rootApiPath}/account',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response?.statusCode != HttpStatus.NO_CONTENT) {
        return Future.error(Exception(
          'Error ${response?.statusCode} while deleting account : ${response?.statusMessage}',
        ));
      }
      await globals.sessionManager.getSession();
      return const StatusResponse(status: 204);
    } on DioException {
      // add "catch (dioError)" for debugging
      rethrow;
    } catch (dioError) {
      rethrow;
    }
  }

  Future<StatusResponse> setLanguage(String language) async {
    return const StatusResponse();
  }

  Future<StatusResponse> setTheme(String theme) async {
    return const StatusResponse();
  }
}
