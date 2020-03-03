import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import 'package:scanmakan/model/user_model.dart';
import './bloc.dart';

class UserProffileBloc extends Bloc<UserProffileEvent, UserProffileState> {
  @override
  UserProffileState get initialState => InitialUserProffileState();

  @override
  Stream<UserProffileState> mapEventToState(
    UserProffileEvent event,
  ) async* {
    try {
      if (event is RequestUserProffile) {
        yield new LoadingUserProffileState();
        var userProffile = await UserRepository.userProfile;
        if (userProffile != null)
          yield new UserProffileFounded(userProffile);
        else {
          yield new UserProffileFounded(UserModel(
              age: 0,
              beratBadan: 0,
              disase: [],
              gender: "Laki-Laki",
              name: "",
              tinggiBadan: 0));
        }
      } else if (event is SaveUserProffileEvent) {
        yield new LoadingUserProffileState();
        print("Save event");
        var save = await UserRepository.saveUserProfile(event.model);
         var userProffile = await UserRepository.userProfile;
        yield new UserProffileFounded(userProffile);
      }
    } catch (eror) {
      print("eror"+eror.toString());
      yield new ErrorUserProffileState();
      throw new Exception("ini eror");
    }
  }
}
