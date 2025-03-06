import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project_ui/Features/Home/presention/Models/BottomNavigationModel.dart';
import 'package:graduation_project_ui/const.dart';

class Custombottomnavigatiorbar extends StatefulWidget {
  const Custombottomnavigatiorbar({super.key});

  @override
  State<Custombottomnavigatiorbar> createState() =>
      _CustombottomnavigatiorbarState();
}

class _CustombottomnavigatiorbarState extends State<Custombottomnavigatiorbar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const ShapeDecoration(
        color: KPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      child: Row(
        children: BottomNavigationBarList.asMap().entries.map((e) {
          var index = e.key;
          var itemS = e.value;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: navigatorIcon(
                isActive: selectedIndex == index,
                bottomNavigationBarEntity: itemS,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class navigatorIcon extends StatelessWidget {
  const navigatorIcon({
    super.key,
    required this.isActive,
    required this.bottomNavigationBarEntity,
  });
  final bool isActive;
  final BottomNavigationBarEntity bottomNavigationBarEntity;
  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveIcon(
            image: bottomNavigationBarEntity.Activeimage,
            title: bottomNavigationBarEntity.title,
          )
        : inActiveIcon(image: bottomNavigationBarEntity.Activeimage);
  }
}

class inActiveIcon extends StatelessWidget {
  const inActiveIcon({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(image);
  }
}

class ActiveIcon extends StatelessWidget {
  const ActiveIcon({super.key, required this.image, required this.title});
  final String image, title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFEEEEEE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: ShapeDecoration(
                color: KPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Center(
                  child: SizedBox(
                      height: 15, width: 15, child: SvgPicture.asset(image))),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Center(
                child: Text(title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
