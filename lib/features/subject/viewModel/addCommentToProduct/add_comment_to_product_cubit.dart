import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'add_comment_to_product_state.dart';

class AddCommentToProductCubit extends Cubit<AddCommentToProductState> {
  AddCommentToProductCubit() : super(AddCommentToProductInitial());
  var commentController = TextEditingController();

  Future<void> addCommentToProduct({
    required int? productId,
  }) async {
    
  }
}
