

import 'package:creen/features/subject/viewModel/deleteCommentfromPost/delete_comment_from_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCommentCubit extends Cubit<DeleteCommentStates>{
  DeleteCommentCubit():super(onIntialComment());

  Future<void> deleteCommentFromPost()async{
    print("delete comment from post");
  }

}