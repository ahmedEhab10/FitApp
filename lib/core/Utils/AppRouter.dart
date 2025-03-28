import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/Auth/Login/ui/Login_view.dart';
import 'package:graduation_project_ui/Features/Auth/SignUp/ui/signUp_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Home_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Main_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/setting_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/Help_user.dart';
import 'package:graduation_project_ui/Features/Nutrition/Presention/view/Nutrition_view.dart';
import 'package:graduation_project_ui/Features/OnBoarding/onboarding_view.dart';
import 'package:graduation_project_ui/Features/Set_Up/Set_Up_Page.dart';
import 'package:graduation_project_ui/Features/Set_Up/widgets/The_Gender.dart';
import 'package:graduation_project_ui/Features/Splash/SpalshView.dart';
import 'package:graduation_project_ui/Features/User_Profile/presention/view/user_profile_view.dart';
import 'package:graduation_project_ui/Features/community/presention/view/community_view.dart';
import 'package:graduation_project_ui/Features/workout/presention/view/WorkOut_view.dart';

abstract class AppRoute {
  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Spalshview(),
    ),
    GoRoute(
      path: '/OnBoardingView',
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: '/Login_view',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/Sign_Up',
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: '/Set_Up',
      builder: (context, state) => const SetUpPage(),
    ),
    GoRoute(
      path: '/The_Gander',
      builder: (context, state) => const TheGender(),
    ),
    GoRoute(
      path: '/Main_view',
      builder: (context, state) => const MainView(),
    ),
    GoRoute(
      path: '/Home_view',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/User_profile',
      builder: (context, state) => const UserProfileView(),
    ),
    GoRoute(
      path: '/WorkOut_view',
      builder: (context, state) => const WorkoutView(),
    ),
    GoRoute(
      path: '/Nutritions_view',
      builder: (context, state) => const NutritionView(),
    ),
    GoRoute(
      path: '/Community_view',
      builder: (context, state) => const CommunityView(),
    ),
    GoRoute(
      path: '/Setting',
      builder: (context, state) => const SettingView(),
    ),
    GoRoute(
      path: '/HelpUser',
      builder: (context, state) => const HelpUser(),
    ),
  ]);
}
