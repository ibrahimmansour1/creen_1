import 'package:creen/features/market/viewModel/allProducts/all_products_cubit.dart';
import 'package:creen/features/market/viewModel/specificProduct/specific_product_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/features/market/repo/reaction_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import '../../../../core/utils/widgets/text_button.dart';

part 'reaction_state.dart';

class ReactionCubit extends Cubit<ReactionState> {
  ReactionCubit() : super(ReactionInitial());

  Future<void> likeProduct(
    BuildContext context, {
    required bool isLike,
    @required int? productId,
  }) async {
    _changeProductFavStatus(
      context,
      productId: productId,
    );
    emit(ReactionLoading());

    try {
      var reactionData = await ReactionRepo.react(
        isLike: isLike,
        productId: productId,
      );
      if (reactionData == null) {
        _changeProductFavStatus(
          context,
          productId: productId,
        );
        emit(ReactionError());
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: 'يرجى التحقق من الاتصال بالانترنت',
            widget: [
              SizedBox(
                width: Sizes.screenWidth() * 0.3,
                child: CustomTextButton(
                  title: 'ok',
                  function: () {
                    NavigationService.goBack();
                  },
                ),
              ),
            ],
          ),
        );
        return;
      }
      if (reactionData.status == true) {
        emit(ReactionDone());
      } else {
        _changeProductFavStatus(
          context,
          productId: productId,
        );
        emit(ReactionError());
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: reactionData.message ?? '',
            widget: [
              SizedBox(
                width: Sizes.screenWidth() * 0.3,
                child: CustomTextButton(
                  title: 'Ok',
                  function: () {
                    NavigationService.goBack();
                  },
                ),
              ),
            ],
          ),
        );
      }
    } on LaravelException catch (error) {
      emit(ReactionError());
      showDialog(
        context: context,
        builder: (_) => CustomDialog(
          title: error.exception,
          widget: [
            SizedBox(
              width: Sizes.screenWidth() * 0.3,
              child: CustomTextButton(
                title: 'Ok',
                function: () {
                  NavigationService.goBack();
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  _changeProductFavStatus(BuildContext context, {int? productId}) async {
    await Future.delayed(
      const Duration(
        milliseconds: 2,
      ),
    );
    try {
      context.read<AllProductsCubit>().changeProductFavStatus(
            productId: productId,
          );
    } catch (e) {}
    try {
      context.read<SpecificProductCubit>().changeProductFavStatus(
            // productId: productId,
          );
    } catch (e) {}
  }
}
