import 'package:flutter/material.dart';

class DialogNotifi extends StatelessWidget {
  //final String content;
  const DialogNotifi({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Text("The password wrong , please check it a again"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
