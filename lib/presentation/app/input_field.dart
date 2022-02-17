import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType? textInputType;
  final IconData? prefixIcon;
  final String? label;
  final String? hint;
  final Function(String) onChanged;
  final String? errorText;
  final InputBorder? border;
  final Widget? suffix;
  final bool readOnly;

  const InputField({
    Key? key,
    required this.prefixIcon,
    required this.onChanged,
    this.textInputType,
    this.label,
    this.hint,
    this.errorText,
    this.border,
    this.suffix,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        focusedBorder:  border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
        border: border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: Theme.of(context).primaryColor,
        ),
        errorText: errorText,
        hintText: hint,
        suffix: suffix,
      ),
      onChanged: onChanged,
      readOnly: readOnly,
    );
  }
}
