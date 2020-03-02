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
    try{
      if(event is RequestUserProffile){
        yield new LoadingUserProffileState();
        var userProffile = await UserRepository.userProfile;
        if(userProffile != null)
        yield new UserProffileFounded(userProffile);
        else{
          yield new UserProffileFounded(UserModel.dummy());
        }
      }else if (event is SaveUserProffileEvent){
        yield new LoadingUserProffileState();
        print("Save event");
        print(event.model.gender);
        var save = await UserRepository.saveUserProfile(event.model);
        yield new UserProffileFounded(save);

      }
    }catch(eror){
      throw new Exception("ini eror");
    }
   
  }
}
