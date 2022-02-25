import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType? textInputType;
  final IconData? prefixIcon;
  final String? label;
  final String? hint;
  final Function(String)? onChanged;
  final String? errorText;
  final InputBorder? border;
  final AutovalidateMode? autoValidateMode;
  final Widget? suffix;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const InputField({
    Key? key,
    this.prefixIcon,
    this.onChanged,
    this.textInputType,
    this.label,
    this.hint,
    this.errorText,
    this.border,
    this.suffix,
    this.readOnly = false,
    this.controller,
    this.validator,
    this.autoValidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: autoValidateMode,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        focusedBorder: border ??
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
