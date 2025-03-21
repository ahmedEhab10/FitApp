import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/CustomBottomnavigatiorBar.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/widgets/home_view_body.dart';
import 'package:graduation_project_ui/core/Repo/Exercise_Repo.dart';
import 'package:graduation_project_ui/core/Services/get_it_Service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeViewBody();
  }
}
