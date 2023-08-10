import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_detail_page/post_detail_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/posts.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }


  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Post Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: PostDetailWidget(post: post),
        )
    );
  }
}
