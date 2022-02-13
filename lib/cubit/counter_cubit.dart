import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit() : super(CounterState(counterValue: 0));
  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, isIncreased: true));
  void decrrement() => emit(
      CounterState(counterValue: state.counterValue - 1, isIncreased: false));

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }

  @override
  void onChange(Change<CounterState> change) {
    print(change.toString());
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error.toString());
    super.onError(error, stackTrace);
  }
}
