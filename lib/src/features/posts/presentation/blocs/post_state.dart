import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';

class PostState {
  const PostState({
    this.posts,
    this.apiFailure,
    this.isLoading = true,
  });
  final List<PostModel>? posts;
  final ApiFailure? apiFailure;
  final bool isLoading;

  PostState copyWith(
      {bool? isLoading, List<PostModel>? posts, ApiFailure? apiFailure}) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      apiFailure: apiFailure ?? this.apiFailure,
    );
  }
}
