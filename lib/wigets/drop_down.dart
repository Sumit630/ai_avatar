import 'package:ai_avatar/utils/cons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/color.dart';
import '../utils/text_style.dart';

class TDropDown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const TDropDown({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: inter.medium.get14.black),
        1.ph,
        DropdownButtonFormField2<String>(
          isExpanded: true,
          value: items.contains(selectedValue) ? selectedValue : null,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: inter.regular.get14.black),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
            filled: true,
            fillColor: AppColors.colorTextFilBG,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.colorTextFilBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.colorTextFilBorder),
            ),
          ),
          style: inter.regular.get14.deemBlack,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.zero,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down, color: AppColors.colorDeemBlackOP),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColors.colorTextFilBG,
            ),
          ),
        ),
      ],
    );
  }
}
