String? stringValidation(String? string) =>
    string!.isEmpty ? 'Field cannot be empty' : null;

String? emailValidation(String? email) {
  bool validateEmail = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email!);
  if (!validateEmail) {
    return 'Email is not valid';
  }
  return null;
}

String? passwordValidation(String? string) {
  bool validatePassword =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(string!);
  if (!validatePassword) {
    return "Min. of 8 letters, at least 1 uppercase letter and 1 number";
  }

  return null;
}
