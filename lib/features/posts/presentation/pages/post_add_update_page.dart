import 'package:clean_architecture_posts_app/core/widgets/appbar/appbar_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/SnackBarMessage.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/posts.dart';
import '../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;

  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: isUpdatePost ? "Edit Post" : "Add Post"),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            //show snackbar , navigate
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
//return widget
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}
