import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyTextField extends StatelessWidget {
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final int minLines;

  const EventlyTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.stroke),
    );
    return TextField(
      decoration: InputDecoration(
        border: border,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: minLines != 1 ? 16 : 8),
        errorBorder: border,
        disabledBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border,
        hintText: hintText,
        hintStyle: AppStyles.secText14regular,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: SvgPicture.asset(prefixIcon!),
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: SvgPicture.asset(suffixIcon!),
              )
            : null,
        filled: true,
        fillColor: AppColors.white,
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        suffixIconConstraints: BoxConstraints(maxHeight: 24),
      ),
      minLines: minLines,
      maxLines: minLines,
      obscureText: obscureText,
      style: AppStyles.mainText14regularH,
      cursorColor: AppColors.mainColor,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: (text) {
        if (onChanged != null) {
          onChanged!(text);
        }
      },
    );
  }
}
