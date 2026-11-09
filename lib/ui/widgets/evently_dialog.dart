import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

Future<bool?> eventlyShowDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String cancel,
  required String confirm,
}) async {
  final theme = Theme.of(context);

  return await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle().copyWith(color: theme.colorScheme.onSecondary),
      ),
      content: Text(
        content,
        style: AppStyles.mediumTextStyle16.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // Close the dialog
          child: Text(
            cancel,
            style: AppStyles.semiBoldTextStyle14.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true); // Close the dialog
          },
          child: Text(
            confirm,
            style: AppStyles.semiBoldTextStyle14.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
