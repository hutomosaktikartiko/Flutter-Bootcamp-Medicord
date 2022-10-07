import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({
    super.key,
    required this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(message ?? "-"),
      ),
    );
  }
}
