import 'package:flutter/material.dart';
import 'package:nonoprice/utility/material_context_extension.dart';

class LoadingErrorPageAndroid extends StatelessWidget {
  final String errorTitle;
  final String errorMessage;
  final Function? onRetry;

  const LoadingErrorPageAndroid({
    Key? key,
    required this.errorTitle,
    required this.errorMessage,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorTitle,
            style: context.headlineSmall?.copyWith(color: Colors.red[900]),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            errorMessage,
            style: context.bodyLarge?.copyWith(color: Colors.red[900]),
          ),
          const SizedBox(
            height: 8.0,
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 32,
            ),
            onPressed: () => onRetry?.call(),
          )
        ],
      ),
    );
  }
}
