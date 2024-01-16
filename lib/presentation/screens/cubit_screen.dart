import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CounterCubit(), // llamamos el counterCubit del directorio bloc
        child: const _CubitCounterView());
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {
    // ! 1. forma de llamar a cubits
    // En caso de que cambie el valor el watch volvera a redibujar el valor
    final counterState = context.watch<CounterCubit>().state;

    return Scaffold(
        appBar: AppBar(
          title: Text('Cubit counter: ${counterState.transactionCount}'),
          actions: [
            IconButton(
                onPressed: () => context.read<CounterCubit>().reset(), icon: const Icon(Icons.refresh_outlined))
          ],
        ),
        // ! 2. forma de llamar a cubits
        body: Center(child: BlocBuilder<CounterCubit, CounterState>(
          // buildWhen: (previous, current) => current.counter != previous.counter,
          builder: (context, state) {
            return Text('Counter value: ${state.counter}');
          },
        )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //!  Se tiene que agregar el heroTag en caso de que tengamos mas de 1 FloatingActionButton
            FloatingActionButton(
              heroTag: '1',
              // ! 3. forma de llamar a cubits
              onPressed: () => context.read<CounterCubit>().increaseBy(3),
              
              child: const Text('+3'),
            ),
            const SizedBox(height: 15),
            FloatingActionButton(
              heroTag: '2',
              onPressed: () => context.read<CounterCubit>().increaseBy(2),
              child: const Text('+2'),
            ),
            const SizedBox(height: 15),

            FloatingActionButton(
              heroTag: '3',
              onPressed: () => context.read<CounterCubit>().increaseBy(1),
              child: const Text('+1'),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }
}
