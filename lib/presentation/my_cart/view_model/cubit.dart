import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/my_cart/view_model/states.dart';

class MyCartCubit extends Cubit<MyCartStates> {
  MyCartCubit() : super(MyCartInitState());
  static MyCartCubit get(context) => BlocProvider.of(context);

   int counter = 1;
  void incressCounter() {
    counter++;
    emit(IncressCounterState());
  }
   void decressCounter() {
    counter--;
    emit(DecressCounterState());

  }
}
