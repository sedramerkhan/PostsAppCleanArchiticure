import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/SnackBarMessage.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_state.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {

  final int postId;

  const DeletePostBtnWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: ()=>deleteDialog(context),
    icon: const Icon(Icons.delete),
    label: const Text("Delete"),
    style: ButtonStyle(
    backgroundColor:
    MaterialStateProperty.all(Colors.redAccent)));
  }

  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdatePostState) {

                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {

              if(state is LoadingAddDeleteUpdatePostState){

                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }

              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }

}
