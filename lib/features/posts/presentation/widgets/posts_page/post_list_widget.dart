import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/posts.dart';
import '../../pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return listItem(context, posts[index]);
        },
        itemCount: posts.length);
  }

  Widget listItem(BuildContext context, Post post) {
    const double radius = 16;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => PostDetailPage(post: post)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(radius),
                      topLeft: Radius.circular(radius)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    post.title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(post.body,
                    style: const TextStyle(fontSize: 16, color: primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
