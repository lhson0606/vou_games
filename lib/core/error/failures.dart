import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class WeekPassFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class ExistedAccountFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NoUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class WrongPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class UnmatchedPassFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class NotLoggedInFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class EmailVerifiedFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class TooManyRequestsFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class UnknownFailure extends Failure{
  @override
  List<Object?> get props => [];
}
class FailureWithMessage extends Failure{
  final String message;
  FailureWithMessage({required this.message});
  @override
  List<Object?> get props => [message];
}