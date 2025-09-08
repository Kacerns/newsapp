import 'package:equatable/equatable.dart';

abstract class FailureError extends Equatable {
  final String message;
  const FailureError(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailureError extends FailureError {
  const ServerFailureError(super.message);
}

class ConnectionFailureError extends FailureError {
  const ConnectionFailureError(super.message);
}

class ParsingFailureError extends FailureError {
  const ParsingFailureError(super.message);
}

class UnknownFailureError extends FailureError {
  const UnknownFailureError(super.message);
}
