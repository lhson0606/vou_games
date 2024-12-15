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