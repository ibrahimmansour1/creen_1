import 'package:creen/features/live/viewModel/live/live_main_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
int liveIndex = 0;

class LiveMainCubit extends Cubit<LiveMainStates>{
  LiveMainCubit():super(InitialLiveMainState() );



  static LiveMainCubit get(BuildContext context)=>BlocProvider.of(context);

  void itemTap(){
    liveIndex = 1;
    emit(UpdateIndexState());
  }


}