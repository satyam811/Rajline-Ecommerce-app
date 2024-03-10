import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raj_lines/res/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator,
      this.keyboardType,
      required this.label,
      this.maxLength});
  final TextEditingController controller;
  final String hintText;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: AppColor.textfieldBorderColor));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        SizedBox(height: 4.h),
        SizedBox(
          height: 64.h,
          child: TextFormField(
            obscureText: obscureText,
            controller: widget.controller,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: const BorderSide(color: AppColor.blueButtonColor),
              ),
              contentPadding: EdgeInsets.only(left: 16.w),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.poppins(
                color: AppColor.textfieldBorderColor.withOpacity(0.9),
              ),
              suffixIconConstraints:
                  BoxConstraints(maxHeight: 20.h, maxWidth: 30.w),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: SvgPicture.asset(
                      'assets/icons/${obscureText ? "eye-regular" : "eye-slash-regular"}.svg',
                      fit: BoxFit.fill),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
