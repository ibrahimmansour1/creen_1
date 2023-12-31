part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}
class ProfileChangeDarkMode extends ProfileState {}

class ProfileLoading extends ProfileState {}

class UpdateProfileLoading extends ProfileState {
  const UpdateProfileLoading({
    required this.mode,
  });
  final UpdatingMode mode;

  @override
  List<Object?> get props => [mode];
}

class ProfileDone extends ProfileState {}

class GenderStateChanged extends ProfileState {
  const GenderStateChanged({
    required this.gender,
  });
  final String gender;
  @override
  List<Object?> get props => [
        gender,
      ];
}

class ProfileImagePicked extends ProfileState {
  const ProfileImagePicked({
    required this.image,
  });
  final File? image;

  @override
  List<Object?> get props => [
        image,
      ];
}

class CoverImagePicked extends ProfileState {
  const CoverImagePicked({
    required this.image,
  });
  final File? image;

  @override
  List<Object?> get props => [
        image,
      ];
}

class FollowStateChanged extends ProfileState {
  const FollowStateChanged({
    required this.isFollow,
    required this.userId,
  });
  final int userId;
  final bool isFollow;
  @override
  List<Object> get props => [
        isFollow,
        userId,
      ];
}

class FollowingRate extends ProfileState {}

class ProfileError extends ProfileState {}
