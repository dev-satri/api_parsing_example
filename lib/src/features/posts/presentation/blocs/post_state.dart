import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/add_post_model.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';

class PostState {
  const PostState({
    this.posts,
    this.apiFailure,
    this.isLoading = true,
    this.isAdding = false,
    this.addPostModel,
    this.addPostFailure,
  });
  final List<PostModel>? posts;
  final ApiFailure? apiFailure;
  final ApiFailure? addPostFailure;

  final bool isLoading;
  final bool isAdding;
  final AddPostModel? addPostModel;

  PostState copyWith(
      {bool? isLoading,
      bool? isAdding,
      List<PostModel>? posts,
      ApiFailure? apiFailure,
      ApiFailure? addPostFailure,
      AddPostModel? addPostModel}) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      isAdding: isAdding ?? this.isAdding,
      posts: posts ?? this.posts,
      apiFailure: apiFailure ?? this.apiFailure,
      addPostModel: addPostModel ?? this.addPostModel,
      addPostFailure: addPostFailure ?? this.addPostFailure,
    );
  }
}
