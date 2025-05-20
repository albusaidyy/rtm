import 'package:flutter/material.dart';
import 'package:rtm/utils/color_palette.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.message,
    super.key,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppTheme.kPrimaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Loading...',
            style: const TextStyle(
              color: AppTheme.kPrimaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
