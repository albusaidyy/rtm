import 'package:flutter/material.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/extensions.dart';

class VisitStatWidget extends StatelessWidget {
  const VisitStatWidget({
    required this.completedPercent,
    required this.pendingPercent,
    required this.cancelledPercent,
    super.key,
  });

  final double completedPercent;
  final double pendingPercent;
  final double cancelledPercent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.kCompletedColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Completed ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor,
                      ),
                    ),
                    TextSpan(
                      text: '''${completedPercent.toStringAsFixed(0)}%''',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor.addOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.kPendingColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Pending ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor,
                      ),
                    ),
                    TextSpan(
                      text: '''${pendingPercent.toStringAsFixed(0)}%''',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor.addOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.kCancelledColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Cancelled ',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor,
                      ),
                    ),
                    TextSpan(
                      text: '''${cancelledPercent.toStringAsFixed(0)}%''',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Graphik',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.kBlackColor.addOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
