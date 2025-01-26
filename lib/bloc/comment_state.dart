import 'package:kawi_app/model/comment_model.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;

  CommentLoaded(this.comments);
}

class CommentError extends CommentState {
  final String error;

  CommentError(this.error);
}
