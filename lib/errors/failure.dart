abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class LocationFailure extends Failure {
  LocationFailure({required super.errorMessage});
}
