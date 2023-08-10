import 'package:clean_architecture_posts_app/core/widgets/appbar/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/posts.dart';
import '../widgets/post_detail_page/post_detail_widget.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Post Detail"),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailWidget(post: post),
    ));
  }
}
