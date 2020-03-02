import 'package:meta/meta.dart';

@immutable
abstract class LoginState {}
  
class InitialLoginState extends LoginState {}

class LoginFail extends LoginState{
    final String error;

   LoginFail({ @required  this.error});
}

class LoginSucces extends LoginState{}

class LoginLoading extends LoginState{}