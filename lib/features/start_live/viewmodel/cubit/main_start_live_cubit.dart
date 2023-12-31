import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/main_start_live_state.dart';

class MainStartLiveCubit extends Cubit<MainStartLiveStates> {
  MainStartLiveCubit() : super(InitialMainStartLiveState());

  static get(BuildContext context) => BlocProvider.of(context);

  void selectItem(BuildContext context, {required Widget page}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
