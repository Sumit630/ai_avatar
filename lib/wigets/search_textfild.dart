import 'package:flutter/material.dart';
import '../utils/color.dart';

class CustomSearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final Color backgroundColor;

  const CustomSearchTextField({
    super.key,
    required this.controller,
    this.hintText = 'Search',
    this.onChanged,
    this.backgroundColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onChanged,
      cursorColor: AppColors.colorHendingColor,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:  Icon(Icons.search, color: AppColors.colorHendingColor),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        filled: true,
        fillColor: backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorTextFilBorder),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.colorTextFilBorder),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
