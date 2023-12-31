part of 'specific_product_cubit.dart';

abstract class SpecificProductState extends Equatable {
  const SpecificProductState();

  @override
  List<Object> get props => [];
}

class SpecificProductInitial extends SpecificProductState {}

class SpecificProductLoading extends SpecificProductState {}

class SpecificProductDone extends SpecificProductState {}

class SpecificProductError extends SpecificProductState {}

class SpecificProductIndexUpdate extends SpecificProductState {
  const SpecificProductIndexUpdate({
    required this.index,
  });
  final int index;
}

class SpecificProductFavStateChanged extends SpecificProductState {
  const SpecificProductFavStateChanged({
    required this.isFav,
  });
  final bool isFav;

  @override
  // TODO: implement props
  List<Object> get props => [
        isFav,
      ];
}
