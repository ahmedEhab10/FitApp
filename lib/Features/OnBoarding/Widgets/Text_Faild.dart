import 'package:flutter/material.dart';
import 'package:graduation_project_ui/const.dart';

class TextFaild extends StatelessWidget {
  TextFaild({super.key, required this.obscureText, this.text});
  bool obscureText;
  String? text;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // لون الخلفية (مشابه للصورة)
        hintText: text, // النص التوضيحي
        hintStyle: const TextStyle(
          color: Colors.black, // لون النص التوضيحي
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ), // مساحة داخلية للنص
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // الحواف المستديرة
          borderSide: const BorderSide(
            color: Colors.transparent, // بدون حدود
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: KDarkerPrimaryColor, // حدود أثناء التركيز
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
