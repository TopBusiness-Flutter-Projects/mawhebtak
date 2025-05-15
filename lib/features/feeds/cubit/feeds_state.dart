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
