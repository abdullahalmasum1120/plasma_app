// ignore_for_file: unnecessary_new, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final Widget child;
  final Size size;
  final VoidCallback? onTap;

  const MyFilledButton({
    Key? key,
    required this.child,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: size,
        padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        primary: new Color(0xFFFF2156),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
