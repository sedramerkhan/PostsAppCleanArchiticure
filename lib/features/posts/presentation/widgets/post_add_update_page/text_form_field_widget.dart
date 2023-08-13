import 'package:clean_architecture_posts_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final bool multiLines;
  final TextEditingController controller;

  const TextFormFieldWidget({
    Key? key,
    required this.name,
    required this.multiLines,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (val) => val!.isEmpty ? "$name Can't be Empty" : null,
        style: const TextStyle(color: primaryColor),
        decoration: InputDecoration(
          hintText: name,
          hintStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
          enabledBorder: multiLines
              ? const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: primaryColor),
                )
              : const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: secondaryColor),
                ),
          focusedBorder: multiLines
              ? null
              : const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: secondaryColor),
                ),
          errorBorder: multiLines
              ? null
              : const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.redAccent),
                ),
          focusedErrorBorder: multiLines
              ? null
              : const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.redAccent),
                ),
        ),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),
    );
  }
}
