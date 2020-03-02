import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:scanmakan/Repositori/user_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => InitialLoginState();
  final UserRepository userRepository = new UserRepository();
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
      if (event is LoginButtonPress) {
      yield LoginLoading();

      try {
        final token = await UserRepository.loginUser(
           event.username,
           event.password,
        );
        if(token.user != null){
          yield LoginSucces();
        }else{
          yield LoginFail(error: "Password Salah");
        }
      } catch (error) {
        print("Eror"+error.toString());
        yield LoginFail(error: error.toString());
      }
    }
    }
  }

