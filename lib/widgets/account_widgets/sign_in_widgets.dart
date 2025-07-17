import 'package:flutter/material.dart';
import 'package:crypto_app/shared/gg_and_fb_btUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/screen/main_screen.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isEmailValid = false;
  bool obsocurePassword = true;

  void validateEmail(String value) {
    setState(() {
      isEmailValid = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    });
  }

  void _navigatortoCreateAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 3),
      ),
    );
  }

  //

  void _navigatortoHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(initialIndex: 0),
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print('Đăng nhập thành công!');
      _navigatortoHome();
    } on FirebaseAuthException catch (e) {
      print('Lỗi: $e');
    }
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            'We provide a full range of forex and crypto trading services for you.',
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            onChanged: validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'youremail@gmail.com',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              suffixIcon:
                  isEmailValid ? Icon(Icons.check, color: Colors.green) : null,
            ),
            controller: _emailController,
          ),
          SizedBox(height: 10),
          //
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: obsocurePassword,
            decoration: InputDecoration(
              hintText: '•••••••••••••',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obsocurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obsocurePassword = !obsocurePassword;
                  });
                },
              ),
            ),
          ),
          //
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                signIn(_emailController.text, _passwordController.text);
              },
              child: Text('Sign in'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
            ),
          ),

          SizedBox(height: 20),
          //
          GoogleandFacebookSignInButton(),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have an account?'),
              SizedBox(width: 10),
              GestureDetector(
                onTap: _navigatortoCreateAccount,
                child: Text(
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                  "Create an account",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
