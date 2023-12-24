import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/categories_model.dart';
import '../../repo/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  List<Categories>? _categories = [];
  List<Categories> get categories => [...?_categories];

  Future<void> getCategories(context) async {
    emit(CategoriesLoading());

    try {
      var categoriesData = await CategoriesRepo.getCategories(context);

      if (categoriesData == null) {
        emit(CategoriesError());
        return;
      }

      if (categoriesData.status == true) {
        _categories = categoriesData.data;
        emit(CategoriesDone());
      } else {
        emit(CategoriesError());
      }
    } catch (_) {
      emit(CategoriesError());
    }
  }

  int categoryIndexByCategoryId({int? categoryId}) {
    return (_categories?.indexWhere(
          (element) => element.id == categoryId,
        ) ??
        -1);
  }
}
