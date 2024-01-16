import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  void increaseBy(int value) {
    // Una de las ventajas de cubit es inmutable entonces para cambiar su valor debemos usar emit
    emit(state.copyWith( //Usamos el copyWIth para acceder al anterior estado y hacer los cambios que necesitemos
        counter: state.counter + value,
        transactionCount: state.transactionCount + 1));
  }

  void reset() {
    emit(state.copyWith(
        counter: 0,  
      ));
  }
}
