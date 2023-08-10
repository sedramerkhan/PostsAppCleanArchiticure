import 'package:flutter/material.dart';

import '../../../domain/entities/posts.dart';
import '../post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final post = posts[index];
          return ListTile(
            leading: Text(post.id.toString()),
            title: Text(
              post.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              post.body,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (_) => PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: posts.length);
  }
}
