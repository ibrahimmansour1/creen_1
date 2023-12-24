import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/BMICalculator/viewModel/bmiMainTab/bmi_main_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BmiMainTabScreen extends StatefulWidget {
  const BmiMainTabScreen({super.key});

  @override
  State<BmiMainTabScreen> createState() => _BmiMainTabScreenState();
}

class _BmiMainTabScreenState extends State<BmiMainTabScreen> {
  late BmiMainTabCubit bmiMainTabCubit;

  @override
  void initState() {
    bmiMainTabCubit = context.read<BmiMainTabCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiMainTabCubit, BmiMainTabState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: bmiMainTabCubit.currentTab,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bmiMainTabCubit.tabIndex,
            onTap: bmiMainTabCubit.onIndexChanged,
            backgroundColor: Colors.black,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white38,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: 'settings'.translate,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.run_circle),
                label: 'steps'.translate,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                label: 'goals'.translate,
              ),
            ],
          ),
        );
      },
    );
  }
}
