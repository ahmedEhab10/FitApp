import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Home_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/Fav_View/fav_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/progress_view.dart';
import 'package:graduation_project_ui/Features/Home/presention/view/setting_view.dart';

class MainViewBody extends StatelessWidget {
  const MainViewBody({super.key, required this.currentViewIndex});
  final int currentViewIndex;
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentViewIndex,
      children: const [HomeView(), ProgressView(), FavView(), SettingView()],
    );
  }
}
