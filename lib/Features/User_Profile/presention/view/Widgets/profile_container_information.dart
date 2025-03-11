import 'package:flutter/material.dart';

class profile_container_information extends StatelessWidget {
  const profile_container_information({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xff896CFE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
          child: Row(
            children: [
              SizedBox(width: 5),
              Column(
                children: [
                  Text(
                    '75Kg',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'weight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              SizedBox(
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
                    '28',
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
                    '1.68Cm',
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
