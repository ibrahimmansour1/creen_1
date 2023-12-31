part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterDone extends RegisterState {}

class RegisterError extends RegisterState {}

class RadioValueStateChanged extends RegisterState {
  const RadioValueStateChanged({
    required this.groupValue,
  });
  final String groupValue;
  @override
  List<Object> get props => [groupValue];
}
