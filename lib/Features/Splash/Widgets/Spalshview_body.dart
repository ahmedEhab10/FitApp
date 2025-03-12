import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/constant.dart';
import 'package:graduation_project_ui/core/Services/Shared_Preferences_Singlton.dart';

class SpalshviewBody extends StatefulWidget {
  const SpalshviewBody({super.key});

  @override
  State<SpalshviewBody> createState() => _SpalshviewBodyState();
}

class _SpalshviewBodyState extends State<SpalshviewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigatToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Logo.png'),
              const SizedBox(
                height: 15,
              ),
              Image.asset('assets/images/FITBODY.png')
            ],
          ),
        ),
      ),
    );
  }

  void NavigatToHomeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      bool seen = SharedPreferencesSinglton.getBool(onBoardingSeenKey) ?? false;
      GoRouter.of(context)
          .pushReplacement(seen ? '/Login_view' : '/OnBoardingView');
    });
  }
}
