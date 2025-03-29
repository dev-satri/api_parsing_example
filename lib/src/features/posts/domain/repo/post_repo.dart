import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<ApiFailure, List<PostModel>>> fetchPosts();
}
