part of 'bmi_main_tab_cubit.dart';

abstract class BmiMainTabState extends Equatable {
  const BmiMainTabState();

  @override
  List<Object> get props => [];
}

class BmiMainTabInitial extends BmiMainTabState {}

class BmiMainTabIndexStateChanged extends BmiMainTabState {
  const BmiMainTabIndexStateChanged({
    required this.index,
  });
  final int index;

  @override
  List<Object> get props => [
        index,
      ];
}
