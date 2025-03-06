import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SummaryPage extends StatelessWidget {
  final String gender;
  final int age;
  final int weight;
  final int height;

  const SummaryPage(
      {super.key,
      required this.gender,
      required this.age,
      required this.weight,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Information",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Gender: $gender",
                style: const TextStyle(color: Colors.white70, fontSize: 18)),
            Text("Age: $age",
                style: const TextStyle(color: Colors.white70, fontSize: 18)),
            Text("Weight: $weight KG",
                style: const TextStyle(color: Colors.white70, fontSize: 18)),
            Text("Height: $height CM",
                style: const TextStyle(color: Colors.white70, fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/Home_view');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              child: const Text("Done",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
