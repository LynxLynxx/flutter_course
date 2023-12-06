import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class ConnectionFailure extends Failure {
  ConnectionFailure({required super.message});
}
