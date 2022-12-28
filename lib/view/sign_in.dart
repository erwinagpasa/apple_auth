import 'package:apple_auth/bloc/auth_bloc.dart';
import 'package:apple_auth/view/dashboard.dart';
import 'package:apple_auth/view/sign_up.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf9fcff),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Center(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null &&
                                            !EmailValidator.validate(value)
                                        ? 'Enter a valid email'
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    border: OutlineInputBorder(),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return value != null && value.length < 6
                                        ? "Enter min. 6 characters"
                                        : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SocialLoginButton(
                                  backgroundColor: const Color(0xFF2f4858),
                                  height: 50,
                                  text: 'Sign In',
                                  borderRadius: 4,
                                  fontSize: 16,
                                  textColor: Colors.white,
                                  buttonType:
                                      SocialLoginButtonType.generalLogin,
                                  imageWidth: 20,
                                  onPressed: () {
                                    _authenticateWithEmailAndPassword(context);
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text.rich(
                            TextSpan(
                                //apply style to all
                                children: [
                                  TextSpan(
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2f4858),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Sign up',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF098c5d),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text("Or continue with"),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Ink(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  width: 0.2,
                                  color: const Color(0xFFa0b1cd),
                                  style: BorderStyle.solid,
                                ),
                                color: const Color(0xFFf3f8fc),
                              ),
                              child: IconButton(
                                  color: const Color(0xFFa0b1cd),
                                  icon: const FaIcon(FontAwesomeIcons.google),
                                  onPressed: () {
                                    _authenticateWithGoogle(context);
                                  }),
                            ),
                            Ink(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  width: 0.2,
                                  color: const Color(0xFFa0b1cd),
                                  style: BorderStyle.solid,
                                ),
                                color: const Color(0xFFf3f8fc),
                              ),
                              child: IconButton(
                                  color: const Color(0xFFa0b1cd),
                                  icon: const FaIcon(FontAwesomeIcons.apple),
                                  onPressed: () {}),
                            ),
                            Ink(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  width: 0.2,
                                  color: const Color(0xFFa0b1cd),
                                  style: BorderStyle.solid,
                                ),
                                color: const Color(0xFFf3f8fc),
                              ),
                              child: IconButton(
                                  color: const Color(0xFFa0b1cd),
                                  icon:
                                      const FaIcon(FontAwesomeIcons.facebookF),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
