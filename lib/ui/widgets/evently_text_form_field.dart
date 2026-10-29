import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyTextFormField extends StatefulWidget {
  final String hintText;
  final String prefixIcon;
  final String? suffixIcon;
  final String? suffixIconActive;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const EventlyTextFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.suffixIconActive,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  State<EventlyTextFormField> createState() => _EventlyTextFormFieldState();
}

class _EventlyTextFormFieldState extends State<EventlyTextFormField> {
  late bool _isObscured = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.stroke),
    );

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        border: border,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: AppColors.red),
        ),
        disabledBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: AppColors.red, width: 1.5),
        ),
        labelText: widget.hintText,
        labelStyle: AppStyles.secText14regular,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: SvgPicture.asset(widget.prefixIcon),
        ),
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
              onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 8),
                child: SvgPicture.asset(_isObscured ? widget.suffixIcon! : widget.suffixIconActive!),
              ),
            )
            : null,
        filled: true,
        fillColor: AppColors.white,
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        suffixIconConstraints: BoxConstraints(maxHeight: 24),
      ),
      keyboardType: widget.keyboardType,
      obscureText: _isObscured,
      style: AppStyles.mainText14regularH,
      cursorColor: AppColors.mainColor,
      cursorErrorColor: AppColors.red,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
