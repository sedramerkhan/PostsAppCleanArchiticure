import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;

  const MessageDisplayWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.sizeOf(context).height / 3,
        child: SingleChildScrollView(
          child: Text(
            message,
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
