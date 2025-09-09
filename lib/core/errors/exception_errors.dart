class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({required this.message});
}

class ParsingException implements Exception {
  final String message;
  ParsingException({required this.message});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});
}
