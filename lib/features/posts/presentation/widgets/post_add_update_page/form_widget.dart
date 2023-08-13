import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_theme.dart';
import '../../../domain/entities/posts.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_event.dart';
import 'form_submit_btn.dart';

class FormWidget extends StatefulWidget {
  final Post? post;
  final bool isUpdatePost;

  const FormWidget({
    Key? key,
    required this.post,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.post?.title ?? "";
    _bodyController.text = widget.post?.body ?? "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double radius = 16;

    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: SingleChildScrollView(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: TextFormFieldWidget(
                        name: "Title",
                        multiLines: false,
                        controller: _titleController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 25),
                    child: TextFormFieldWidget(
                      name: "Body",
                      multiLines: true,
                      controller: _bodyController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormSubmitBtn(
                      isUpdatePost: widget.isUpdatePost,
                      onPressed: validateFormThenUpdateOrAddPost),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
