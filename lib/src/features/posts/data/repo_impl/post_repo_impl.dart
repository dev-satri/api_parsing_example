import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/add_post_model.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';
import 'package:api_test/src/features/posts/data/sources/remote_source.dart';
import 'package:api_test/src/features/posts/domain/repo/post_repo.dart';
import 'package:dartz/dartz.dart';

class PostRepositoryImpl implements PostRepository {
  const PostRepositoryImpl(this._remoteSource);
  final RemoteSource _remoteSource;

  @override
  Future<Either<ApiFailure, List<PostModel>>> fetchPosts() async {
    return await _remoteSource.fetchPosts();
  }

  @override
  Future<Either<ApiFailure, AddPostModel>> addPost() async {
    return await _remoteSource.addPost();
  }
}
