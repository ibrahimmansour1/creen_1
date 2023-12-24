import 'package:bloc/bloc.dart';
import 'package:creen/features/BMICalculator/view/bmi_calc_screen.dart';
import 'package:creen/features/BMICalculator/view/goals_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../view/bmi_settings_screen.dart';

part 'bmi_main_tab_state.dart';

class BmiMainTabCubit extends Cubit<BmiMainTabState> {
  BmiMainTabCubit() : super(BmiMainTabInitial());
  final List<Widget> _tabs = [
    const BmiSettingsScreen(),
    const BMICalcScreen(),
    const GoalsScreen(),
  ];

  Widget get currentTab => _tabs[tabIndex];

  int tabIndex = 1;

  void onIndexChanged(int index) {
    tabIndex = index;
    emit(BmiMainTabIndexStateChanged(index: index));
  }
}
