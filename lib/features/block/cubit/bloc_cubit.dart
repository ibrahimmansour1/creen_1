
import 'package:creen/features/block/model/block_model.dart';
import 'package:creen/features/block/repo/block_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/themes/enums.dart';
import '../../../core/utils/routing/navigation_service.dart';
import 'bloc_state.dart';

class BlocCubit extends Cubit<BlockStates>{
  BlocCubit():super(InitialBlockState());
  BlocCubit get(context)=> BlocProvider.of(context);


}

Future<void> submitBlock({
  required ReportType blockType,
  required int blockTypeId,
  bool block = false,
}) async {

  // emit(LoadingBlockState());
  print("loading");
  try {
    BlockModel? blockUserData ;

      blockUserData = await BlockRepo.blockUser(blockType: blockType, blockTypeId: blockTypeId,block: block);

    if (blockUserData == null) {
      // emit(ErrorBlockState());
      print("error");

      return;
    }
    Fluttertoast.showToast(
      msg: blockUserData.message ?? '',
    );
    // emit(DoneBlockState());
    print("done");
    if (blockUserData.status == true) {
      NavigationService.goBack();
    }
  } catch (e) {
    // emit(ErrorBlockState());
    print("error");
  }
}