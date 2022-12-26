// import 'package:apple_sign_in_firebase_flutter/apple_sign_in_available.dart';
// import 'package:apple_sign_in_firebase_flutter/auth_service.dart';
import 'package:apple_auth/apple_sign_in_available.dart';
import 'package:apple_auth/auth_service.dart';
import 'package:flutter/material.dart' hide ButtonStyle;
import 'package:provider/provider.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final user = await authService.signInWithApple();
      // ignore: avoid_print
      print('uid: ${user.uid}');
    } catch (e) {
      // ignore: todo
      // TODO: Show alert here
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appleSignInAvailable.isAvailable)
              AppleSignInButton(
                style: ButtonStyle.black,
                type: ButtonType.signIn,
                onPressed: () => _signInWithApple(context),
              ),
          ],
        ),
      ),
    );
  }
}
