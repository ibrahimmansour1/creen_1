import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/features/chat/repo/validate_store_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

part 'validate_story_created_at_state.dart';

class ValidateStoryCreatedAtCubit extends Cubit<ValidateStoryCreatedAtState> {
  ValidateStoryCreatedAtCubit() : super(ValidateStoryCreatedAtInitial());

  final _storedValidateDateKey = 'created_at';

  bool get _isValidToCallAPI =>
      !GetStorage().hasData(_storedValidateDateKey) ||
      DateTime.now()
              .difference(DateTime.tryParse(
                      GetStorage().read(_storedValidateDateKey) ?? '') ??
                  DateTime.now())
              .inDays >=
          1;

  Future<void> validateStory() async {
    log('$_isValidToCallAPI ${GetStorage().read(_storedValidateDateKey)}',
        name: 'validateStory');
    if (!_isValidToCallAPI) {
      return;
    }

    var validateData = await ValidateStoriesRepo.validateStories();
// print("validateData${validateData}");
    if (validateData == null) {
      return;
    }
    if (validateData.status == true) {
      await GetStorage().write(
        _storedValidateDateKey,
        DateTime.now().toIso8601String(),
      );
    }
  }
}
