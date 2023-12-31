part of 'address_data_cubit.dart';

abstract class AddressDataState extends Equatable {
  const AddressDataState();

  @override
  List<Object> get props => [];
}

class AddressDataInitial extends AddressDataState {}

class CountriesLoading extends AddressDataState {}

class CitiesLoading extends AddressDataState {}

class Done extends AddressDataState {}

class Error extends AddressDataState {}
