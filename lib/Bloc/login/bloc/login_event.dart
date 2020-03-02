import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPress extends  LoginEvent{
  final String username,password;
  LoginButtonPress({this.username,this.password});
}
