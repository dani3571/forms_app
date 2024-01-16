import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const _BlocCounterView(),
    );
  }
}

class _BlocCounterView extends StatelessWidget {
  const _BlocCounterView();

  void increaseCounterBy(BuildContext context, [int value = 1]) {
    // ! Con add creamos un nuevo evento
    context.read<CounterBloc>().add(CounterIncreased(value));
  }

  @override
  Widget build(BuildContext context) {
    final counterState = context.watch<CounterBloc>().state;
    return Scaffold(
        appBar: AppBar(
          title: Text('Bloc counter: ${counterState.transactionCount}'),
          actions: [
            IconButton(
                onPressed: () => context.read<CounterBloc>().add(CounterReset()), icon: const Icon(Icons.refresh_outlined))
          ],
        ),
        body: Center(
          child: context.select((CounterBloc counterBloc) =>
              Text('Counter value: ${counterBloc.state.counter}')),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //!  Se tiene que agregar el heroTag en caso de que tengamos mas de 1 FloatingActionButton
            FloatingActionButton(
              heroTag: '1',
              onPressed: () => context
                  .read<CounterBloc>()
                  .add(const CounterIncreased(3)), // * Sin funcion
              child: const Text('+3'),
            ),
            const SizedBox(height: 15),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () => increaseCounterBy(context, 2), // * Con funcion
              child: const Text('+2'),
            ),
            const SizedBox(height: 15),

            FloatingActionButton(
              heroTag: '3',
              onPressed: () => increaseCounterBy(context, 1), // * Con funcion
              child: const Text('+1'),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }
}
