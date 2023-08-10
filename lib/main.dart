import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_event.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// it is better to provide each Bloc in its used place
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
      BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Posts App',
      home: const PostsPage(),
    ));
  }
}
