part of 'bmi_calc_cubit.dart';

abstract class BmiCalcState extends Equatable {
  const BmiCalcState();

  @override
  List<Object> get props => [];
}

class BmiCalcInitial extends BmiCalcState {

}

class CreateBmiCalcLoading extends BmiCalcState {}

class BmiCalcLoading extends BmiCalcState {}

class BmiCalcDone extends BmiCalcState {

}

class BmiCalcError extends BmiCalcState {}

class StartStateChanged extends BmiCalcState {
  const StartStateChanged({required this.hasStarted});
  final bool hasStarted;

  @override
  List<Object> get props => [hasStarted];
}

class StepStateChanged extends BmiCalcState {
  const StepStateChanged({
    required this.steps,
    required this.timeStamp,
  });
  final int steps;
  final DateTime timeStamp;

  @override
  List<Object> get props => [steps, timeStamp];
}

class StatusStateChanged extends BmiCalcState {
  const StatusStateChanged({
    required this.status,
    required this.timeStamp,
  });
  final String status;
  final DateTime timeStamp;

  @override
  List<Object> get props => [status, timeStamp];
}
