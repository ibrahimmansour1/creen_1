import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/features/addressData/repo/countries_repo.dart';
import 'package:equatable/equatable.dart';
import '../../models/countries_model.dart';
import '../../models/cities_model.dart';
import '../../repo/cities_repo.dart';

part 'address_data_state.dart';

class AddressDataCubit extends Cubit<AddressDataState> {
  AddressDataCubit() : super(AddressDataInitial());

  List<Countries>? _countries = [];
  List<City>? _cities = [];

  List<Countries> get countries => [...?_countries];
  List<City> get cities => [...?_cities];

  Future<void> getCountries() async {
    emit(CountriesLoading());
    var countriesData = await CountriesRepo.getCountries();
    if (countriesData == null) {
      emit(Error());
      return;
    }
    if (countriesData.status == true) {
      _countries = countriesData.data;
      emit(Done());
    } else {
      emit(Error());
    }
  }
  // $2y$10$UfagVMP4T01WDj1Yh6a8tuRcVJdhAlVb8ZrMJFm2C9l1FQTZhKxy
  // $2y$10$ppjx7SMepEivA1OZnCOe4O.cR7xouaLdMh5au7rx38R..B9.//I9
  Future<void> getCitiesByCountryId({
    required int? countryId,
  }) async {
    emit(CitiesLoading());
    var citiesData = await CitiesRepo.getCitiesByCountryId(
      countryId: countryId,
    );
    if (citiesData == null) {
      emit(Error());
      return;
    }
    if (citiesData.status == true) {
      _cities = citiesData.data;
      emit(Done());
    } else {
      emit(Error());
    }
  }
}
