import 'package:flutter/material.dart';

class DialogNotifi extends StatelessWidget {
  //final String content;
  const DialogNotifi({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("The password wrong"),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}
