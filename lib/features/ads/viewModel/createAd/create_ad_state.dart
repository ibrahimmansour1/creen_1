part of 'create_ad_cubit.dart';

abstract class CreateAdState extends Equatable {
  const CreateAdState();

  @override
  List<Object> get props => [];
}

class CreateAdInitial extends CreateAdState {}

class CreateAdLoading extends CreateAdState {}

class CreateAdDone extends CreateAdState {}

class CreateAdError extends CreateAdState {}

class AddImages extends CreateAdState {
  const AddImages({
    required this.imagesLength,
  });
  final int imagesLength;

  @override
  List<Object> get props => [imagesLength];
}

class AddVideos extends CreateAdState {
  const AddVideos({
    required this.videosLength,
  });
  final int videosLength;

  @override
  List<Object> get props => [videosLength];
}
