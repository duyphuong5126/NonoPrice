import 'package:flutter/cupertino.dart';
import 'package:nonoprice/utility/cupertino_context_extension.dart';

class LoadingPageIOS extends StatelessWidget {
  final String? message;

  const LoadingPageIOS({
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
                const CupertinoActivityIndicator(
                  radius: 16,
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
          : const CupertinoActivityIndicator(
              radius: 16,
            ),
    );
  }
}
