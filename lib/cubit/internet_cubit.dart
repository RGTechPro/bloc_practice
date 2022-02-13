import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? streamSubscription;
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    streamSubscription = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectivityType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectivityType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
        //print('hio');
      }
    });
  }
  emitInternetConnected(ConnectivityType connectivityType) =>
      emit(InternetConnected(connectivityType: connectivityType));
  emitInternetDisconnected() => emit(InternetDisconnected());
  @override
  Future<void> close() {
//  streamSubscription.cancel();
    return super.close();
  }
}
