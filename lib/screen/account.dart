import 'package:flutter/material.dart';
import 'package:crypto_app/widgets/account_widgets/sign_in_widgets.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
      child: Signin(),
    );
  }
}
