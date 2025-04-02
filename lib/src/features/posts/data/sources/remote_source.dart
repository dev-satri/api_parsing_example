import 'dart:convert';

import 'package:api_test/src/core/network/api_endpoints.dart';
import 'package:api_test/src/core/network/api_failure.dart';
import 'package:api_test/src/features/posts/data/model/add_post_model.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class RemoteSource {
  var client = http.Client();

  Future<Either<ApiFailure, List<PostModel>>> fetchPosts() async {
    final url = Uri.parse(ApiEndpoints.posts);
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> list = jsonDecode(response.body);
        final posts =
            list.map((e) => PostModel.fromJson(e) as PostModel).toList();
        return Right(posts);
      } else {
        return Left(ApiFailure(message: 'Invalid Response'));
      }
    } catch (e) {
      return Left(ApiFailure(message: 'Could not fetch'));
    }
  }

  Future<Either<ApiFailure, AddPostModel>> addPost() async {
    final url = Uri.parse(ApiEndpoints.posts);
    try {
      final response = await client.post(url);
      if (response.statusCode == 201) {
        final dynamic json = jsonDecode(response.body);
        final addPost = AddPostModel.fromJson(json);
        return Right(addPost);
      } else {
        return Left(ApiFailure(message: 'Invalid Response'));
      }
    } catch (e) {
      return Left(ApiFailure(message: 'Could not fetch'));
    }
  }
}
