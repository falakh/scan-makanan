import 'package:equatable/equatable.dart';
import 'package:scanmakan/model/user_model.dart';

abstract class UserProffileEvent {
  const UserProffileEvent();
}

class SaveUserProffileEvent extends UserProffileEvent{
  final UserModel model;
  const SaveUserProffileEvent({this.model});
}
class RequestUserProffile extends UserProffileEvent{
}