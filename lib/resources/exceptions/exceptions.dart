import 'package:dio/dio.dart';

class SchemeConsistencyException implements Exception {
  final String message;

  SchemeConsistencyException([this.message = 'Schemes consistency error']);

  String toString() {
    if (message == null) return '$SchemeConsistencyException';
    return '$SchemeConsistencyException: $message';
  }
}

abstract class DiagnosticMessageException implements Exception {
  String get diagnosticMessage;
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message, {Response<dynamic> response});
}

class ApiInternalServerException extends ApiException {
  ApiInternalServerException() : super('Internal Server Error');
}

class ApiDataNotFoundException extends ApiException {
  ApiDataNotFoundException() : super('Data Not Found Error');
}

abstract class LocalizeMessageException implements Exception {}

class HttpException implements Exception {
  final String _message;
  //  final LocalizedString localizedMessage;
  HttpException(this._message);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException(String message)
      : super(
          "Error During Communication: $message",
        );
}

class BadRequestException extends HttpException {
  BadRequestException(String message, {Response<dynamic> response})
      : super(
          "Invalid Request: $message",
        );
}

class BadUrlException extends HttpException {
  BadUrlException(String message)
      : super(
          "Bad URL: $message",
        );
}

class UnauthorisedException extends HttpException {
  String message;
  UnauthorisedException(this.message, {Response<dynamic> response})
      : super("Unauthorised: $message");
}

class ResourceNotFoundException extends HttpException {
  ResourceNotFoundException(String message, {Response<dynamic> response})
      : super(
          "$message",
        );
}

class InvalidInputException extends HttpException {
  InvalidInputException(String message) : super("Invalid Input: $message");
}

class ApiUnauthorizedException extends HttpException {
  ApiUnauthorizedException(String message) : super(message);
}

class UnprocessableException extends HttpException {
  String message;

  UnprocessableException(this.message, {Response<dynamic> response})
      : super(message);
}
