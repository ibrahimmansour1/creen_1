part of 'view_promotion_cubit.dart';

abstract class ViewPromotionState extends Equatable {
  const ViewPromotionState();

  @override
  List<Object> get props => [];
}

class ViewPromotionInitial extends ViewPromotionState {}

class ViewPromotionLoading extends ViewPromotionState {}

class ViewPromotionDone extends ViewPromotionState {}

class ViewPromotionError extends ViewPromotionState {}
