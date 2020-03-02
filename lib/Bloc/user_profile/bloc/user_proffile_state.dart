import 'package:equatable/equatable.dart';
import 'package:scanmakan/model/user_model.dart';

abstract class UserProffileState {
  const UserProffileState();
}

class InitialUserProffileState extends UserProffileState{
}

class LoadingUserProffileState extends UserProffileState{
}

class ErrorUserProffileState extends UserProffileState{
  final String message;

  const ErrorUserProffileState({this.message});
}

class UserProfileNotFound extends UserProffileState{

}

class UserProffileFounded extends UserProffileState{
  final UserModel result;

  UserProffileFounded(this.result);

}