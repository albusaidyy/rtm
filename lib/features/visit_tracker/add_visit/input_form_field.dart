import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rtm/utils/_index.dart';

class InputFormField extends StatefulWidget {
  const InputFormField({
    required this.hintText,
    required this.controller,
    this.hidePassword,
    this.isTextBox,
    this.isUnderLine,
    this.isEmail,
    this.currency,
    this.enabled = true,
    this.toggleHidePassword,
    this.onTap,
    this.prefixIconAssetUrl,
    this.readOnly,
    this.inputFormatter,
    this.keyboardType,
    this.onChanged,
    this.maxLength,
    this.decoration,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.iconSize = 15,
    this.fillColor,
    this.suffixIcon,
    this.borderWidth = 1,
    super.key,
  });
  final String hintText;
  final TextEditingController controller;
  final String? prefixIconAssetUrl;
  final bool? hidePassword;
  final VoidCallback? toggleHidePassword;
  final VoidCallback? onTap;
  final VoidCallback? onChanged;
  final bool? isTextBox;
  final bool? isUnderLine;
  final bool? isEmail;
  final Widget? currency;
  final bool? enabled;
  final bool? readOnly;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final int? maxLength;
  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final double iconSize;
  final double borderWidth;
  final Widget? suffixIcon;
  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      readOnly: widget.readOnly ?? false,
      controller: widget.controller,
      maxLength: widget.maxLength,
      obscureText: widget.hidePassword ?? false,
      minLines: widget.toggleHidePassword != null
          ? null
          : widget.isTextBox != null
              ? 3
              : 1,
      maxLines: widget.toggleHidePassword != null ? 1 : 5,
      onTap: widget.onTap,
      onChanged: widget.onChanged == null ? (_) {} : (_) => widget.onChanged!(),
      inputFormatters: [
        ...widget.inputFormatter ?? [],
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      style: widget.textStyle ??
          TextStyle(
            fontFamily: 'Helvetica Neue',
            color: widget.isEmail != null
                ? AppTheme.kPrimaryColor
                : AppTheme.kBlackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
      decoration: widget.decoration ??
          InputDecoration(
            disabledBorder: widget.isUnderLine != null
                ? const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.kAccent4GreyColor,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: widget.enabled == false
                          ? AppTheme.kGreyColor
                          : AppTheme.kSecondaryGreyColor,
                      width: widget.borderWidth,
                    ),
                  ),
            enabledBorder: widget.isUnderLine != null
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.kAccent4GreyColor,
                      width: widget.borderWidth,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: widget.enabled == false
                          ? AppTheme.kGreyColor
                          : AppTheme.kSecondaryGreyColor,
                      width: widget.borderWidth,
                    ),
                  ),
            border: widget.isUnderLine != null
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppTheme.kAccent4GreyColor,
                      width: widget.borderWidth,
                    ),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: widget.enabled == false
                          ? AppTheme.kGreyColor
                          : AppTheme.kSecondaryGreyColor,
                      width: widget.borderWidth,
                    ),
                  ),
            suffixIcon: widget.toggleHidePassword != null
                ? IconButton(
                    onPressed: widget.toggleHidePassword,
                    splashRadius: 18,
                    icon: Icon(
                      !(widget.hidePassword == null ||
                              widget.hidePassword == false)
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppTheme.kBlackColor,
                      size: 18,
                    ),
                  )
                : widget.suffixIcon,
            contentPadding: widget.isUnderLine != null
                ? EdgeInsets.zero
                : widget.contentPadding ??
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
            fillColor: widget.fillColor ?? AppTheme.kBackgroundColor,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 14,
                  color: widget.isUnderLine != null
                      ? AppTheme.kAccent12GreyColor
                      : AppTheme.kDullGreyColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
    );
  }
}
