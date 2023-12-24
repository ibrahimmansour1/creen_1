part of 'create_report_cubit.dart';

abstract class CreateReportState extends Equatable {
  const CreateReportState();

  @override
  List<Object> get props => [];
}

class CreateReportInitial extends CreateReportState {}

class CreateReportLoading extends CreateReportState {}

class CreateReportDone extends CreateReportState {}

class CreateReportError extends CreateReportState {}

class ReasonStateChanged extends CreateReportState {
  const ReasonStateChanged({
    required this.reason,
  });
  final String reason;

  @override
  List<Object> get props => [reason];
}
