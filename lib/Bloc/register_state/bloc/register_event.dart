import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email});



  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

   PasswordChanged({@required this.password});


  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

   Submitted({
    @required this.email,
    @required this.password,
  });

 

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

