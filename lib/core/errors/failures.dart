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

class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure({
    String message = 'Pas de connexion internet',
  }) : super(errorMessage: message);
}

class CacheFailure extends Failure {}

class LocationFailure extends Failure {
  const LocationFailure({
    String message = 'Erreur lors de la récupération de la position',
  }) : super(errorMessage: message);
}
