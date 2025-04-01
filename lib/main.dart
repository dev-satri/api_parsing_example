import 'package:api_test/di.dart';
import 'package:api_test/src/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PostsPage());
  }
}
