import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';
import 'package:api_test/src/features/posts/domain/repo/post_repo.dart';
import 'package:dartz/dartz.dart';

class PostUsecase {
  const PostUsecase(this._postRepository);
  final PostRepository _postRepository;

  Future<Either<ApiFailure, List<PostModel>>> fetchPosts() async {
    return await _postRepository.fetchPosts();
  }
}
