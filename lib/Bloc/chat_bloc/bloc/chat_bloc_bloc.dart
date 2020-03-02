import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ChatBlocBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  @override
  ChatBlocState get initialState => InitialChatBlocState();

  @override
  Stream<ChatBlocState> mapEventToState(
    ChatBlocEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
