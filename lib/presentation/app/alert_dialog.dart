import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final Widget? content;
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;

  const MyAlertDialog({
    Key? key,
    required this.content,
    this.onPositive,
    this.onNegative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Row(
        children: const [
          Icon(
            Icons.warning,
            color: Colors.amber,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text("Alert"),
        ],
      ),
      content: content,
      actions: [
        GestureDetector(
          onTap: () {
            onPositive;
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Yes",
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onNegative;
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "No",
            ),
          ),
        ),
      ],
    );
  }
}
