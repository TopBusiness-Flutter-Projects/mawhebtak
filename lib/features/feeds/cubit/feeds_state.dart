import 'dart:io';

import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

sealed class FeedsState {}

final class FeedsStateLoadingMore extends FeedsState {}

final class FeedsStateLoading extends FeedsState {}

final class FeedsStateLoaded extends FeedsState {
  final PostsModel? postsModel;

  FeedsStateLoaded(this.postsModel);
}

final class FeedsStateError extends FeedsState {
  final String errorMessage;

  FeedsStateError(this.errorMessage);
}

final class AddReactionStateLoading extends FeedsState {}

final class AddReactionStateLoaded extends FeedsState {}

final class AddReactionStateError extends FeedsState {
  final String errorMessage;

  AddReactionStateError(this.errorMessage);
}

final class AddPostStateLoading extends FeedsState {}

final class AddPostStateLoaded extends FeedsState {}

final class AddPostStateError extends FeedsState {
  final String errorMessage;

  AddPostStateError(this.errorMessage);
}

class MediaPickedSuccessfullyState extends FeedsState {
  final List<File> files;
  MediaPickedSuccessfullyState(this.files);
}

class MediaPickErrorState extends FeedsState {
  final String error;
  MediaPickErrorState(this.error);
}

class MediaSelectionUpdated extends FeedsState {}

class MediaPickedState extends FeedsState {}

class SuccessSelectNewImageState extends FeedsState {}

class SuccessRemoveImageState extends FeedsState {}

class SuccessRemoveVideoState extends FeedsState {}

class LoadedAddNewViedoState extends FeedsState {}

class AddReactionStateSuccess extends FeedsState {}
