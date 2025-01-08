String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your E-Mail';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid E-Mail';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  } else if (value.length < 5) {
    return 'The password must contain more than five characters.';
  }
  return null;
}

// username validator
String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  } else if (value.length < 5) {
    return 'The username must contain more than five characters.';
  }
  return null;
}

// phone number validator
String? phoneNumberValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  } else if (value.length != 10) {
    return 'The phone number must contain ten characters.';
  }
  return null;
}