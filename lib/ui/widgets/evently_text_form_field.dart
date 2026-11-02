import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyTextFormField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? suffixIconInactive;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final int minLines;

  const EventlyTextFormField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconInactive,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.minLines = 1,
  });

  @override
  State<EventlyTextFormField> createState() => _EventlyTextFormFieldState();
}

class _EventlyTextFormFieldState extends State<EventlyTextFormField> {
  late bool _isObscured = widget.obscureText;
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: AppColors.stroke),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines,
      maxLines: widget.minLines,
      obscureText: _isObscured,
      style: AppStyles.mainText14regularH,
      cursorColor: AppColors.mainColor,
      cursorErrorColor: AppColors.red,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: widget.minLines != 1 ? 16 : 8),
        border: _border,
        errorBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.red),
        ),
        disabledBorder: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        focusedErrorBorder: _border.copyWith(
          borderSide: BorderSide(color: AppColors.red, width: 1.5),
        ),
        labelText: widget.label,
        labelStyle: AppStyles.secText14regular,
        hintText: widget.hintText,
        hintStyle: AppStyles.secText14regular,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12, right: 8),
                child: SvgPicture.asset(widget.prefixIcon!),
              )
            : null,
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.suffixIconInactive != null
                    ? () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12, left: 8),
                  child: SvgPicture.asset(
                    _isObscured ? widget.suffixIconInactive! : widget.suffixIcon!,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: AppColors.white,
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        suffixIconConstraints: BoxConstraints(maxHeight: 24),
      ),
    );
  }
}
