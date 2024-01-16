part of 'counter_bloc.dart';

// ! Con bloc o cubit el state tiene la misma idea
class CounterState extends Equatable {
  final int counter;
  final int transactionCount;
  const CounterState({this.counter = 0, this.transactionCount = 0});

  copyWith({int? counter, int? transactionCount}) => CounterState(
      counter: counter ?? this.counter,
      transactionCount: transactionCount ?? this.transactionCount);

  // ! Condicional para comparar eventos en caso de que cambie el counter o transactionCount
  @override
  List<Object> get props => [counter, transactionCount];
}
