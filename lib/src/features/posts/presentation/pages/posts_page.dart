import 'dart:convert';

import 'package:api_test/src/core/network/api_endpoints.dart';
import 'package:api_test/src/features/posts/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var client = http.Client();
  List<PostModel> posts = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async {
    //GET API URL
    final url = Uri.parse(ApiEndpoints.posts);
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> list = jsonDecode(response.body);

        setState(() {
          posts = list.map((e) => PostModel.fromJson(e) as PostModel).toList();
        });
      } else {
        print('Invalid Response !');
      }
    } catch (e) {
      throw Exception('Could not fetch');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text('${posts[index].id}'),
              title: Text(posts[index].title),
              subtitle: Text(posts[index].body),
            ),
          );
        },
        itemCount: posts.length,
      ),
    );
  }
}
