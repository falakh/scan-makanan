import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class FoodDetectorBloc extends Bloc<FoodDetectorEvent, FoodDetectorState> {
  @override
  FoodDetectorState get initialState => InitialFoodDetectorState();

  @override
  Stream<FoodDetectorState> mapEventToState(
    FoodDetectorEvent event,
  ) async* {
  }
}
