import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyTextField extends StatelessWidget {
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscureText;
  const EventlyTextField({super.key, required this.hintText, this.prefixIcon, this.suffixIcon, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.stroke),
      gapPadding: 16
    );
    return TextField(
      decoration: InputDecoration(
        border:border,
        errorBorder: border,
        disabledBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        labelText: hintText,
        labelStyle: AppStyles.secText14regular,
        prefixIcon: prefixIcon != null ? Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SvgPicture.asset(prefixIcon!),
        ) : null,
        suffixIcon: suffixIcon != null ? Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(suffixIcon!),
        ) : null,
        filled: true,
        fillColor: AppColors.white,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 48,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 48,
        ),
      ),
      obscureText: obscureText,
      style: AppStyles.mainText14regularH,
      cursorColor: AppColors.mainColor,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
