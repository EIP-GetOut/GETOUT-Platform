/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Perry Chouteau <perry.chouteau@epitech.eu>
*/

part of 'service.dart';

class StatusResponse {
  const StatusResponse({this.status = HttpStatus.NOT_FOUND, this.error});

  final int status;
  final String? error;
}

class SessionService extends ServiceTemplate {
//  final String _id = (globals.session != null) ? globals.session!['id'].toString() : '';

  SessionService();

  Future<StatusResponse> changeEmail(String password, String newEmail) async {
    try { /// TODO we need to do something prettier
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
    return const StatusResponse();
  }

  Future<StatusResponse> changePassword(String password, String newPassword) async {
    return const StatusResponse();
  }

  Future<StatusResponse> disconnect() async {
    return const StatusResponse();
  }

  Future<StatusResponse> deleteAccount(String password) async {
    return const StatusResponse();
  }

  Future<StatusResponse> setLanguage(String language) async {
    return const StatusResponse();
  }

  Future<StatusResponse> setTheme(String theme) async {
    return const StatusResponse();
  }

}
