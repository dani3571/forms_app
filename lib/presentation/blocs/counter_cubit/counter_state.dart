part of 'counter_cubit.dart'; // parte de counter_cubit


class CounterState extends Equatable{

  final int counter;
  final int transactionCount; // Cantidad de veces que subio el contador

  // ! Un nuevo estado sera una nueva instancia de la clase
  const CounterState({
    this.counter = 0,
    this.transactionCount = 0,
  });

  // ! Es conveniente crear una copia de nuestro estado actual
  copyWith({
    int? counter,
    int? transactionCount
  }) => CounterState(
    counter: counter ?? this.counter,
    transactionCount: transactionCount ?? this.transactionCount
  );
  // Para solucionar el problema de que se vuelva a hacer el build sin cambiar el valor del counter usamos el package equatable el cual es como una condicional de objetos
  @override
  List<Object> get props => [counter, transactionCount];


}