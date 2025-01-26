abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String password;
  LoginSubmitted(this.password, this.username);
}
