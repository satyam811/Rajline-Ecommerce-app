import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_lines/res/colors.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({super.key, required this.isSelected, required this.text});
  final bool isSelected;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.h,
      width: 26.h,
      decoration: BoxDecoration(
          color: isSelected ? AppColor.blueButtonColor.withOpacity(0.2) : null,
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.blueButtonColor)),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: AppColor.blueButtonColor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class StepWidgetRow extends StatelessWidget {
  const StepWidgetRow({super.key, required this.index});
  final String index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StepWidget(isSelected: index == '1', text: '1'),
        buildHorizontalLine(),
        StepWidget(isSelected: index == '2', text: '2'),
        buildHorizontalLine(),
        StepWidget(isSelected: index == '3', text: '3'),
      ],
    );
  }

  Container buildHorizontalLine() {
    return Container(
      color: AppColor.blueButtonColor,
      height: 2,
      width: 80.w,
    );
  }
}
