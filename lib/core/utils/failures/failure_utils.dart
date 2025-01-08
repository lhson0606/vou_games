import 'package:vou_games/core/error/failures.dart';

import '../../strings/failure_message.dart';

String failureToErrorMessage(Failure failure) {
  switch (failure) {
    case ServerFailure():
      return SERVER_FAILURE_MESSAGE;
    case OfflineFailure():
      return OFFLINE_FAILURE_MESSAGE;
    case TooManyRequestsFailure():
      return TOO_MANY_REQUESTS_FAILURE_MESSAGE;
    case NoUserFailure():
      return NO_USER_FAILURE_MESSAGE;
    case WrongPasswordFailure():
      return WRONG_PASSWORD_FAILURE_MESSAGE;
    default:
      if (failure is FailureWithMessage) {
        return failure.message;
      }

      return UNEXPECTED_FAILURE_MESSAGE;
  }
}
