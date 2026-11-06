import 'package:evently/models/category_dm.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final EventCategory id;

  const CategoryImage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          CategoryDm.getCategoryById(
            id,
          ).getImagePath(ThemeProvider().isDarkMode(context))!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
