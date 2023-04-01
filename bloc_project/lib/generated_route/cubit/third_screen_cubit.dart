import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreenCubit extends Cubit<int>{
  ThirdScreenCubit():super(0);

  void increment(){
    emit(state+1);
  }
}