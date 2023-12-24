part of 'add_new_product_cubit.dart';

abstract class AddNewProductState extends Equatable {
  const AddNewProductState();

  @override
  List<Object> get props => [];
}

class AddNewProductInitial extends AddNewProductState {}

class QtyStateChanged extends AddNewProductState {
  const QtyStateChanged({
    required this.qty,
  });
  final int qty;

  @override
  List<Object> get props => [
        qty,
      ];
}

class AddNewProductLoading extends AddNewProductState {}

class AddNewProductDone extends AddNewProductState {}

class AddNewProductError extends AddNewProductState {}

class MainCatIdStateChanged extends AddNewProductState {
  const MainCatIdStateChanged({
    required this.mainCatId,
  });
  final int mainCatId;

  @override
  List<Object> get props => [
        mainCatId,
      ];
}

class ColorListStateChanged extends AddNewProductState {
  const ColorListStateChanged({
    required this.colorLength,
  });
  final int colorLength;

  @override
  List<Object> get props => [
        colorLength,
      ];
}

class SizesListStateChanged extends AddNewProductState {
  const SizesListStateChanged({
    required this.sizesLength,
  });
  final int sizesLength;

  @override
  List<Object> get props => [
        sizesLength,
      ];
}

class ImagesListStateChanged extends AddNewProductState {
  const ImagesListStateChanged({
    required this.imageLength,
  });
  final int imageLength;

  @override
  List<Object> get props => [
        imageLength,
      ];
}
