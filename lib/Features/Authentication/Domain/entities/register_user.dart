class RegisterUserEntity {
  final String username;
  final String userEmail;
  final String password;

  RegisterUserEntity(
      {required this.password,
      required this.userEmail,
      required this.username});
}
