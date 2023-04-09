// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home_screen.dart';
import '../utils/authentication.dart';

class SignInButton extends StatefulWidget {
  const SignInButton({super.key});

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool _isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isSignedIn
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : InkWell(
                onTap: () async {
                  setState(() {
                    _isSignedIn = true;
                  });
                  User? user =
                      await Authentication.signInWithGoogle(context: context);
                  setState(() {
                    _isSignedIn = false;
                  });

                  if (user != null) {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Sign in successful'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/images/google_logo.png',
                          height: 30,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ]),
                ),
              ));
  }
}
