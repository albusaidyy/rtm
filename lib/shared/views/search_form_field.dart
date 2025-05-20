import 'package:flutter/cupertino.dart';
import 'package:rtm/utils/color_palette.dart';

class SearchFormField extends StatefulWidget {
  const SearchFormField({
    required this.controller,
    required this.hintText,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final void Function(String)? onSubmitted;

  @override
  State<SearchFormField> createState() => _SearchFormFieldState();
}

class _SearchFormFieldState extends State<SearchFormField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: widget.controller,
      placeholder: widget.hintText,
      style: const TextStyle(
        color: AppTheme.kBlackColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      placeholderStyle: const TextStyle(
        color: AppTheme.kAccent12GreyColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      borderRadius: BorderRadius.circular(8),
      onSubmitted: widget.onSubmitted,
    );
  }
}
