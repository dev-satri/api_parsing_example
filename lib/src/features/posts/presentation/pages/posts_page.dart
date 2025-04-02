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
          actions: [
            BlocConsumer<PostBloc, PostState>(
              buildWhen: (previous, current) =>
                  previous.isAdding != current.isAdding,
              listenWhen: (previous, current) =>
                  previous.addPostFailure != current.addPostFailure ||
                  previous.addPostModel != current.addPostModel,
              listener: (context, state) {
                if (state.addPostFailure != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      content: Text(state.apiFailure!.message)));
                }
                if (state.addPostModel != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      content: Text('Successfully Added')));
                }
              },
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      context.read<PostBloc>().add(PostAddEvent());
                    },
                    icon: Icon(state.isAdding ? Icons.refresh : Icons.add));
              },
            ),
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      content: Text('This is a Snackbar')));
                },
                icon: Icon(Icons.notifications)),
          ],
        ),
        body: BlocConsumer<PostBloc, PostState>(
          listenWhen: (p, c) => p.apiFailure != c.apiFailure,
          listener: (context, state) {
            if (state.apiFailure != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  content: Text(state.apiFailure!.message)));
            }
          },
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
