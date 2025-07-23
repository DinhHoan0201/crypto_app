import 'package:crypto_app/model/users_data_model.dart';
import 'package:crypto_app/service/data_users_api.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app/shared/gg_and_fb_btUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto_app/screen/main_screen.dart';
import 'package:crypto_app/widgets/account_widgets/profile.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data;
        if (user == null) {
          return ListView(
            children: [
              SizedBox(height: 10),
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
              TextFormField(
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
                      isEmailValid
                          ? Icon(Icons.check, color: Colors.green)
                          : null,
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
                      obsocurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all fields.')),
                      );
                      return;
                    }
                    signIn(_emailController.text, _passwordController.text);
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
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
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      "Create an account",
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return FutureBuilder<UserPortfolio?>(
            future: getUserData(),
            builder:
                (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : snapshot.hasData
                        ? Profile(userData: snapshot.data!, email: user.email!)
                        : Center(child: Text('No user data found.')),
          );
        }
      },
    );
  }
}
