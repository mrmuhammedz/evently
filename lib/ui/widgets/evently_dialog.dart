import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';

Future<bool?> eventlyShowDialog(
  BuildContext context, {
  required String title,
  required Widget content,
  String? cancel,
  String? confirm,
}) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);

      return AlertDialog(
        title: Text(
          title,
          style: TextStyle().copyWith(color: theme.colorScheme.onSecondary),
        ),
        content: content,
        actions: [
          ?cancel != null
              ? TextButton(
                  onPressed: () =>
                      Navigator.pop(context, false), // Close the dialog
                  child: Text(
                    cancel,
                    style: AppStyles.semiBoldTextStyle14.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                )
              : null,
          ?confirm != null
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context, true); // Close the dialog
                  },
                  child: Text(
                    confirm,
                    style: AppStyles.semiBoldTextStyle14.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                )
              : null,
        ],
      );
    },
  );
}
