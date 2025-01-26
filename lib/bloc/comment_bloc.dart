import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:kawi_app/bloc/comment_event.dart';
import 'package:kawi_app/bloc/comment_state.dart';
import 'package:kawi_app/model/comment_model.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final Dio dio;

  CommentBloc(this.dio) : super(CommentInitial()) {
    // Register the event handler for FetchComments
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final response = await dio.get('https://jsonplaceholder.typicode.com/comments');
        final List<Comment> comments = (response.data as List)
            .map((json) => Comment.fromJson(json))
            .toList();
        emit(CommentLoaded(comments));
      } catch (error) {
        emit(CommentError(error.toString()));
      }
    });
  }
}
