import 'package:api_test/src/features/posts/domain/usecases/post_usecase.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_event.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(this._postUsecase) : super(PostState()) {
    on<PostFetchEvent>(fetchPost);
    on<PostAddEvent>(addPost);
  }

  final PostUsecase _postUsecase;

  void fetchPost(PostFetchEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _postUsecase.fetchPosts();
    response.fold(
      (error) => emit(state.copyWith(isLoading: false, apiFailure: error)),
      (data) => emit(state.copyWith(isLoading: false, posts: data)),
    );
  }

  void addPost(PostAddEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(isAdding: true));
    final response = await _postUsecase.addPost();
    response.fold(
      (error) => emit(state.copyWith(isAdding: false, addPostFailure: error)),
      (data) => emit(state.copyWith(isAdding: false, addPostModel: data)),
    );
  }
}
