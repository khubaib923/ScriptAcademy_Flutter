import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState { initial, gained, lost}

class InternetCubit extends Cubit<InternetState>{
  final Connectivity _connectivity=Connectivity();
  StreamSubscription? _streamSubscription;
  InternetCubit():super(InternetState.initial){
    _streamSubscription=_connectivity.onConnectivityChanged.listen((result) {
      if(result==ConnectivityResult.mobile || result==ConnectivityResult.wifi){
        emit(InternetState.gained);
      }
      else{
        emit(InternetState.lost);

      }

    });

  }
  @override
  Future<void> close() {
    // TODO: implement close
    _streamSubscription!.cancel();
    return super.close();

  }

}