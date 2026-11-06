import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class ThemeDropdown extends StatelessWidget {
  final ThemeProvider themeProvider;
  final AppLocalizations appLocalizations;

  const ThemeDropdown({
    super.key,
    required this.themeProvider,
    required this.appLocalizations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButton(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      iconEnabledColor: theme.colorScheme.onSurface,
      isDense: true,
      value: themeProvider.themeMode,
      onChanged: (ThemeMode? newValue) => themeProvider.setThemeMode(newValue!),
      items: [
        DropdownMenuItem(
          value: ThemeMode.light,
          child: Text(appLocalizations.lightMode),
        ),
        DropdownMenuItem(
          value: ThemeMode.dark,
          child: Text(appLocalizations.darkMode),
        ),
        DropdownMenuItem(
          value: ThemeMode.system,
          child: Text(appLocalizations.systemTheme),
        ),
      ],
    );
  }
}
