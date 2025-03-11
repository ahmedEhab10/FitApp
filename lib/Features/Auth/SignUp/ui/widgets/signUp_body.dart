import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Auth_App_Bar.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/signup_cotinar.dart';
import 'package:graduation_project_ui/const.dart';
import 'package:graduation_project_ui/core/Common/Button.dart';

class SignupBody extends StatelessWidget {
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            AuthAppBar(
              title: 'Create Account',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'let\'s start!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const SignupCotinar(),
            const SizedBox(
              height: 15,
            ),
            const Text('By continuing, you agree to ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: ' Terms of Use ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KPacScoundColor,
                    ),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: ' Privacy Policy.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KPacScoundColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {},
              child: custom_Button(
                text: 'Sign Up',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GoRouter.of(context).pop();
                      },
                    text: ' Log In',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: KPacScoundColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
