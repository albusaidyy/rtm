import 'package:flutter/material.dart';
import 'package:rtm/utils/_index.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel({
    required this.label,
    super.key,
    this.isOptional,
    this.isRequired,
    this.isGrey,
    this.textStyle,
    this.disabled,
    this.cannotEdit,
  });
  final String label;
  final bool? isOptional;
  final bool? disabled;
  final bool? isRequired;
  final bool? cannotEdit;
  final bool? isGrey;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RichText(
          text: TextSpan(
            text: label,
            style: textStyle ??
                TextStyle(
                  color: isGrey != null
                      ? AppTheme.kAccent5GreyColor
                      : AppTheme.kBlackColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
            children: [
              if (isRequired ?? false)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: AppTheme.kErrorColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (cannotEdit ?? false)
                const TextSpan(
                  text: ' (cannot edit)',
                  style: TextStyle(
                    color: AppTheme.kErrorColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
