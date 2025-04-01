import 'package:api_test/di.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_bloc.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_event.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostBloc>()..add(PostFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.apiFailure != null) {
              return Center(child: Text(state.apiFailure!.message));
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text('${state.posts![index].id}'),
                    title: Text(state.posts![index].title),
                    subtitle: Text(state.posts![index].body),
                  ),
                );
              },
              itemCount: state.posts!.length,
            );
          },
        ),
      ),
    );
  }
}
