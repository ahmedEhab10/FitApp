import 'package:flutter/material.dart';
import 'package:graduation_project_ui/core/helper/Get_User_Data.dart';

class profile_container_information extends StatefulWidget {
  const profile_container_information({super.key});

  @override
  State<profile_container_information> createState() =>
      _profile_container_informationState();
}

class _profile_container_informationState
    extends State<profile_container_information> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xff896CFE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Column(
                children: [
                  Text(
                    '${GetUser().weight}Kg',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    'weight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 35),
              Column(
                children: [
                  Text(
                    GetUser().age.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Years Old',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 35),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  width: 20,
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              Column(
                children: [
                  Text(
                    '${GetUser().height}Cm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Height',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
