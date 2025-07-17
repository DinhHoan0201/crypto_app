import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/widgets/home_widgets/porfolio_widget.dart';
import 'package:crypto_app/widgets/home_widgets/body.dart';
import 'package:crypto_app/widgets/home_widgets/functionbutton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          PortfolioWidget(),
          const SizedBox(height: 16),
          Functionbutton(),
          const SizedBox(height: 16),
          Body(),
        ],
      ),
    );
  }
}
