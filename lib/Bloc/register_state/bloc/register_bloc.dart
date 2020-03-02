import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if(event is Submitted){
      yield RegisterState.loading();
      try{
        await UserRepository.registerUser(event.email, event.password);
        await UserRepository.loginUser(event.email, event.password);
        yield RegisterState.success();
      }catch(exception){
        print(exception);
        yield RegisterState.failure();
      }
    }
  }
}
