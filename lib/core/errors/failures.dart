import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  const Failure({this.errorMessage = 'Erreur application'});

  @override
  List<Object> get props => [errorMessage];
}

class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Erreur serveur',
  }) : super(errorMessage: message);
}

class CacheFailure extends Failure {}
