/*
  * validate Email  
  */
String? validateEmail({required String email}) {
  if (email.isEmpty) return "Your email can not be empty";
  // fetching the name of email to validate
  String nameOfEmail = email.substring(0, email.indexOf("@"));
  if (nameOfEmail.length < 5) {
    return "At least 5 characters";
  } else if (nameOfEmail.isEmpty) {
    return "Your name can not be empty";
  } else if (!email.contains("@")) {
    return "Your email is invalid";
  }
  return null;
}
