import 'package:flutter/material.dart';
import 'package:rtm/utils/color_palette.dart';

class FetchErrorWidget extends StatelessWidget {
  const FetchErrorWidget({
    required this.error,
    required this.onRetry,
    super.key,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: AppTheme.kPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'Graphik',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
