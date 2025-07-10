import 'dart:io';

import 'package:mawhebtak/features/feeds/data/models/comments_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

sealed class FeedsState {}

final class FeedsStateLoadingMore extends FeedsState {}

final class FeedsStateLoading extends FeedsState {}
final class FeedsVideoStateUpdated extends FeedsState {}

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

final class CommentsStateLoading extends FeedsState {}

final class CommentsStateLoaded extends FeedsState {
  final CommentsModel? comments;

  CommentsStateLoaded(this.comments);
}

final class CommentsStateError extends FeedsState {
  final String errorMessage;

  CommentsStateError(this.errorMessage);
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

class AddCommentStateLoading extends FeedsState {}

class AddCommentStateSuccess extends FeedsState {}

class AddCommentStateError extends FeedsState {
  final String error;
  AddCommentStateError(this.error);
}

class AddReplyStateLoading extends FeedsState {}

class AddReplyStateLoaded extends FeedsState {}

class AddReplyStateError extends FeedsState {
  final String error;
  AddReplyStateError(this.error);
}

class ReplyingToCommentState extends FeedsState {
  final String commentId;
  final String userName;

  ReplyingToCommentState({required this.commentId, required this.userName});
}

class CancelReplyingState extends FeedsState {}

class DeletePostStateLoading extends FeedsState {}

class DeletePostStateSuccess extends FeedsState {}

class compressVideoLoaded extends FeedsState {}

class FeedsStateUpdated extends FeedsState {}

class ShowReplies extends FeedsState {}

class DeletePostStateError extends FeedsState {
  final String error;
  DeletePostStateError(this.error);
}

class LoadingGetPostDetails extends FeedsState {}

class LoadedGetPostDetails extends FeedsState {}

class ErrorGetPostDetails extends FeedsState {}
