import 'package:flutter/material.dart';
import 'package:nonoprice/utility/material_context_extension.dart';

class LoadingPageAndroid extends StatelessWidget {
  final String? message;

  const LoadingPageAndroid({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: message != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  message!,
                  style: context.bodyLarge,
                )
              ],
            )
          : const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(),
            ),
    );
  }
}
