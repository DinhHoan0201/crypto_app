import 'package:flutter/material.dart';
import 'package:crypto_app/auth/sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleandFacebookSignInButton extends StatelessWidget {
  const GoogleandFacebookSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,

      child: Column(
        children: [
          Text(
            'Or Sign in with Google',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          //)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
              onPressed: () async {
                final user = await signInWithGoogle();
                {
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Welcome ${user.displayName}!')),
                    );
                  }
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.google, color: Colors.red, size: 20),
                  SizedBox(width: 10),
                  Text(
                    'Google',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          //
          SizedBox(height: 10),
          //
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1877F2), // Facebook blue
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.facebook, size: 20),
                  SizedBox(width: 10),
                  Text('Facebook', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
