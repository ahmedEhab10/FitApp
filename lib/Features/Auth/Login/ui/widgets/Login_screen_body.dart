import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Auth_App_Bar.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/widgets/Login_continar.dart';
import 'package:graduation_project_ui/const.dart';
import 'package:graduation_project_ui/core/Common/Button.dart';

import 'package:graduation_project_ui/core/Size_config.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                const AuthAppBar(
                  title: 'Log In ',
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 7,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 3,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit,\n sed do eiusmod tempor incididunt ut labore et dolore\n magna aliqua. ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: SizeConfig.defaultSize! * 4,
                ),
                const LoginContinar(),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/Set_Up');
                  },
                  child: custom_Button(
                    text: 'Log in',
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Don’t have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            GoRouter.of(context).push('/Sign_Up');
                          },
                        text: ' Sign Up',
                        style: const TextStyle(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
