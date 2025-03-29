import 'package:api_test/src/features/posts/presentation/blocs/post_event.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState()) {
    on<PostFetchEvent>(
      (event, emit) {
        emit(state.copyWith(isLoading: true));
      },
    );
  }
}
