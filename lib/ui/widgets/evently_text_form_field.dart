import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventlyTextFormField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final String? suffixIconInactive;
  final Color? suffixIconColor;
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
    this.suffixIconColor,
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
  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: _theme.colorScheme.outline),
    );

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.minLines,
      maxLines: widget.minLines,
      obscureText: _isObscured,
      style: AppStyles.regularTextStyle14H.copyWith(
        color: _theme.colorScheme.onSecondary,
      ),
      cursorColor: _theme.primaryColor,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: widget.minLines != 1 ? 16 : 8,
        ),
        border: border,
        disabledBorder: border,
        enabledBorder: border,
        focusedBorder: border,
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(width: 1.5, color: AppColors.red),
        ),
        labelText: widget.label,
        labelStyle: AppStyles.regularTextStyle14,
        hintText: widget.hintText,
        hintStyle: AppStyles.regularTextStyle14,
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
                  child: SvgAsset(
                    asset: _isObscured
                        ? widget.suffixIconInactive!
                        : widget.suffixIcon!,
                    color: widget.suffixIconColor,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: _theme.colorScheme.surface,
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        suffixIconConstraints: BoxConstraints(maxHeight: 24),
      ),
    );
  }
}
