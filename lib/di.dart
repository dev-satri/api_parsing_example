import 'package:api_test/src/features/posts/data/repo_impl/post_repo_impl.dart';
import 'package:api_test/src/features/posts/data/sources/remote_source.dart';
import 'package:api_test/src/features/posts/domain/repo/post_repo.dart';
import 'package:api_test/src/features/posts/domain/usecases/post_usecase.dart';
import 'package:api_test/src/features/posts/presentation/blocs/post_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance; //sl -> Service Locator

void initDependencies() {
  sources();
  repository();
  usecases();
  blocs();
}

void sources() {
  sl.registerLazySingleton<RemoteSource>(() => RemoteSource());
}

void repository() {
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(sl()));
}

void usecases() {
  sl.registerLazySingleton<PostUsecase>(() => PostUsecase(sl()));
}

void blocs() {
  sl.registerLazySingleton<PostBloc>(() => PostBloc(sl()));
}
