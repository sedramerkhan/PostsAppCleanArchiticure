import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_detail_page/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/posts.dart';
import 'delete_post_btn_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double radius = 16;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 25),
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 25),
              child: Text(post.body,
                  style: const TextStyle(fontSize: 16, color: primaryColor)),
            ),

            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UpdatePostBtnWidget(post: post),
                DeletePostBtnWidget(postId: post.id!),
              ],
            ),
            const SizedBox(height: 20,),

          ],
        ),
      ),


    );
  }
}
