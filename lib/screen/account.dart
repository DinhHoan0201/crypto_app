import 'package:flutter/material.dart';
import 'package:crypto_app/widgets/account_widgets/sign_in_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Signin());
  }
}
