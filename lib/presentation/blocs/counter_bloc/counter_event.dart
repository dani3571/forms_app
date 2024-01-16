part of 'counter_bloc.dart';

// El counter event nos permite indicar los tipos de eventos que ocurriran
abstract class CounterEvent {
  const CounterEvent();

}

class CounterIncreased extends CounterEvent{
  final int value;
  const CounterIncreased(this.value);
}

class CounterReset extends CounterEvent{}
