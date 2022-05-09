class FormValidation {
  static String? checkEmail(String value) {
    if (value.isEmpty || value == null) {
      return "Please Enter Email";
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
      return "Please Enter Valid Email";
    }
  }

  static checkPassword(String value) {
    if (value.isEmpty) {
      return "Please Enter Password";
    } else if (value.length < 6) {
      return "Password must be greater than 5";
    } else {
      return null;
    }
  }

  static String? checkEmpty(String value) {
    if (value.isEmpty) {
      return "Field not be empty";
    } else {
      return null;
    }
  }
}
