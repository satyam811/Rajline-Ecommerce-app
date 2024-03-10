import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_lines/res/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.keyboardType,
      required this.label,
      this.maxLength,
      this.isOpt,
      this.readOnly});
  final TextEditingController controller;
  final String hintText;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? isOpt;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: AppColor.textfieldBorderColor));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            if (isOpt ?? false)
              Text(
                '(Optional)',
                style: GoogleFonts.poppins(
                  color: AppColor.textfieldBorderColor.withOpacity(0.9),
                ),
              )
          ],
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 64.h,
          child: TextFormField(
            controller: controller,
            validator: validator,
            readOnly: readOnly ?? false,
            keyboardType: keyboardType,
            maxLength: maxLength,
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColor.blueButtonColor),
              ),
              contentPadding: EdgeInsets.only(left: 16.w),
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                color: AppColor.textfieldBorderColor.withOpacity(0.9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
