handleException(error) {
  String errorMessage = "";
  switch (error.code) {
    case "ERROR_INVALID_EMAIL":
      errorMessage = "Your email address appers to be malformed.";
      break;
    case "ERROR_WORG_PASSWORD ":
      errorMessage = "Your password is wrong";
      break;
    case "ERROR_USER_NOT_FOUND":
      errorMessage = "Error with this email dosnt't exists";
      break;
    case "ERROR_USER_DISABLED":
      errorMessage = "Error with email has been disabled.";
      break;
    case "ERROR_TO_MANY_REQUESTS":
      errorMessage = "Error to many.Try again letter";
      break;
    case "ERROR_OPERATION_NOT_ALLOWED":
      errorMessage = "Signing in with Email and Password is not enabled.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      errorMessage = "Signing in with Email and Password is not enabled.";
      break;
    case "ERROR_EMAIL_ALREADY_IN_USE":
      "The email has already been registered. Please login or reset your password.";
      break;
    default:
      errorMessage = "An undefined Error happened.";
  }
  return errorMessage;
}
