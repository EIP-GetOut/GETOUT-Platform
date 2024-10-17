/*
** Copyright GETOUT SAS - All Rights Reserved
** Unauthorized copying of this file, via any medium is strictly prohibited
** Proprietary and confidential
** Wrote by Erwan Cariou <erwan1.cariou@epitech.eu>
*/

class HttpStatus {
  static const int CONTINUE = 100;
  static const int SWITCHING_PROTOCOLS = 101;
  static const int PROCESSING = 102;
  static const int OK = 200;
  static const int CREATED = 201;
  static const int ACCEPTED = 202;
  static const int NON_AUTHORITATIVE_INFORMATION = 203;
  static const int NO_CONTENT = 204;
  static const int RESET_CONTENT = 205;
  static const int PARTIAL_CONTENT = 206;
  static const int MULTI_STATUS = 207;
  static const int MULTIPLE_CHOICES = 300;
  static const int MOVED_PERMANENTLY = 301;
  static const int MOVED_TEMPORARILY = 302;
  static const int SEE_OTHER = 303;
  static const int NOT_MODIFIED = 304;
  static const int USE_PROXY = 305;
  static const int TEMPORARY_REDIRECT = 307;
  static const int PERMANENT_REDIRECT = 308;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int PAYMENT_REQUIRED = 402;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int METHOD_NOT_ALLOWED = 405;
  static const int NOT_ACCEPTABLE = 406;
  static const int PROXY_AUTHENTICATION_REQUIRED = 407;
  static const int REQUEST_TIMEOUT = 408;
  static const int CONFLICT = 409;
  static const int GONE = 410;
  static const int LENGTH_REQUIRED = 411;
  static const int PRECONDITION_FAILED = 412;
  static const int REQUEST_TOO_LONG = 413;
  static const int REQUEST_URI_TOO_LONG = 414;
  static const int UNSUPPORTED_MEDIA_TYPE = 415;
  static const int REQUESTED_RANGE_NOT_SATISFIABLE = 416;
  static const int EXPECTATION_FAILED = 417;
  static const int IM_A_TEAPOT = 418;
  static const int INSUFFICIENT_SPACE_ON_RESOURCE = 419;
  static const int METHOD_FAILURE = 420;
  static const int UNPROCESSABLE_ENTITY = 422;
  static const int LOCKED = 423;
  static const int FAILED_DEPENDENCY = 424;
  static const int PRECONDITION_REQUIRED = 428;
  static const int TOO_MANY_REQUESTS = 429;
  static const int REQUEST_HEADER_FIELDS_TOO_LARGE = 431;
  static const int UNAVAILABLE_FOR_LEGAL_REASONS = 451;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int NOT_IMPLEMENTED = 501;
  static const int BAD_GATEWAY = 502;
  static const int SERVICE_UNAVAILABLE = 503;
  static const int GATEWAY_TIMEOUT = 504;
  static const int HTTP_VERSION_NOT_SUPPORTED = 505;
  static const int INSUFFICIENT_STORAGE = 507;
  static const int NETWORK_AUTHENTICATION_REQUIRED = 511;
  static const int NO_INTERNET = 599;
  static const int APP_TIMEOUT = 2;
  static const int APP_ERROR = 1;

  Map<int, String> statusCodeMessages = {
    CONTINUE: 'Continue',
    SWITCHING_PROTOCOLS: 'Switching Protocols',
    PROCESSING: 'Processing',
    OK: 'OK',
    CREATED: 'Created',
    ACCEPTED: 'Accepted',
    NON_AUTHORITATIVE_INFORMATION: 'Non-Authoritative Information',
    NO_CONTENT: 'No Content',
    RESET_CONTENT: 'Reset Content',
    PARTIAL_CONTENT: 'Partial Content',
    MULTI_STATUS: 'Multi-Status',
    MULTIPLE_CHOICES: 'Multiple Choices',
    MOVED_PERMANENTLY: 'Moved Permanently',
    MOVED_TEMPORARILY: 'Moved Temporarily',
    SEE_OTHER: 'See Other',
    NOT_MODIFIED: 'Not Modified',
    USE_PROXY: 'Use Proxy',
    TEMPORARY_REDIRECT: 'Temporary Redirect',
    PERMANENT_REDIRECT: 'Permanent Redirect',
    BAD_REQUEST: 'Bad Request',
    UNAUTHORIZED: 'Unauthorized',
    PAYMENT_REQUIRED: 'Payment Required',
    FORBIDDEN: 'Forbidden',
    NOT_FOUND: 'Not Found',
    METHOD_NOT_ALLOWED: 'Method Not Allowed',
    NOT_ACCEPTABLE: 'Not Acceptable',
    PROXY_AUTHENTICATION_REQUIRED: 'Proxy Authentication Required',
    REQUEST_TIMEOUT: 'Request Timeout',
    CONFLICT: 'Conflict',
    GONE: 'Gone',
    LENGTH_REQUIRED: 'Length Required',
    PRECONDITION_FAILED: 'Precondition Failed',
    REQUEST_URI_TOO_LONG: 'Request-URI Too Long',
    UNSUPPORTED_MEDIA_TYPE: 'Unsupported Media Type',
    REQUESTED_RANGE_NOT_SATISFIABLE: 'Requested Range Not Satisfiable',
    EXPECTATION_FAILED: 'Expectation Failed',
    IM_A_TEAPOT: 'I\'m a Teapot',
    INSUFFICIENT_SPACE_ON_RESOURCE: 'Insufficient Space on Resource',
    METHOD_FAILURE: 'Method Failure',
    UNPROCESSABLE_ENTITY: 'Unprocessable Entity',
    LOCKED: 'Locked',
    FAILED_DEPENDENCY: 'Failed Dependency',
    PRECONDITION_REQUIRED: 'Precondition Required',
    TOO_MANY_REQUESTS: 'Too Many Requests',
    REQUEST_HEADER_FIELDS_TOO_LARGE: 'Request Header Fields Too Large',
    UNAVAILABLE_FOR_LEGAL_REASONS: 'Unavailable For Legal Reasons',
    INTERNAL_SERVER_ERROR: 'Internal Server Error',
    NOT_IMPLEMENTED: 'Not Implemented',
    BAD_GATEWAY: 'Bad Gateway',
    SERVICE_UNAVAILABLE: 'Service Unavailable',
    GATEWAY_TIMEOUT: 'Gateway Timeout',
    HTTP_VERSION_NOT_SUPPORTED: 'HTTP Version Not Supported',
    NO_INTERNET: 'No internet connection',
    APP_TIMEOUT: 'Request Timeout',
    APP_ERROR: 'The application has encountered an unknown error. Please try again later',
  };

  HttpStatus(Map<int, String> messages) {
    overWriteMessages(messages);
  }

  void overWriteMessages(Map<int, String> newMessages) {
    for (int key in newMessages.keys) {
      if (newMessages[key] != null && statusCodeMessages.containsKey(key)) {
        statusCodeMessages[key] = newMessages[key]!;
      }
    }
  }

  String getMessage(int statusCode) {
    if (statusCodeMessages.containsKey(statusCode)) {
      return statusCodeMessages[statusCode]!;
    }
    return statusCodeMessages[APP_ERROR]!;
  }
}