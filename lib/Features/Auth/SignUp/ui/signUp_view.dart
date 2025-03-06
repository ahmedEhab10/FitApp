import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/widgets/signUp_body.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SignupBody()),
    );
  }
}
