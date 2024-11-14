import 'package:bloc/bloc.dart';

class CounterState {
  final int count;
  final bool isMultipleOfFive;

  CounterState({
    required this.count,
    required this.isMultipleOfFive,
  });

  CounterState copyWith({
    int? count,
    bool? isMultipleOfFive,
  }) {
    return CounterState(
      count: count ?? this.count,
      isMultipleOfFive: isMultipleOfFive ?? this.isMultipleOfFive,
    );
  }
}

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class CounterCubit extends Cubit<CounterState> {
  /// {@macro counter_cubit}
  CounterCubit() : super(CounterState(count: 0, isMultipleOfFive: false));
  void increment() {
    final newCount = state.count + 1;
    _emitWithCheck(newCount);
  }

  void decrement() {
    final newCount = state.count - 1;
    _emitWithCheck(newCount);
  }

  void decrementByTwo() {
    final newCount = state.count - 2;
    _emitWithCheck(newCount);
  }

  void multiplyByTwo() {
    final newCount = state.count * 2;
    _emitWithCheck(newCount);
  }

  void reset() {
    emit(CounterState(count: 0, isMultipleOfFive: false));
  }

  void _emitWithCheck(int newCount) {
    emit(CounterState(
      count: newCount,
      isMultipleOfFive: newCount % 5 == 0 && newCount != 0,
    ));
  }

}
