import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_tap_bar.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  EventCategory? _selectedCategoryId;
  late final Stream<List<EventDm>> _eventsStream;
  ThemeData get _theme => Theme.of(context);
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _eventsStream = EventService().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Column(
      children: [
        SizedBox(height: 24),
        buildHeader(user),
        SizedBox(height: 24),
        tapBar(),
        SizedBox(height: 24),
        StreamBuilder<List<EventDm>>(
          stream: _eventsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: _theme.primaryColor),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error.toString()}',
                  style: AppStyles.regularTextStyle14.copyWith(
                    color: AppColors.red,
                  ),
                ),
              );
            } else if (!snapshot.hasData ||
                filterEvents(snapshot.data ?? []).isEmpty) {
              return Center(child: Text(_appLocalizations.noEventsFound));
            }

            return EventsList(events: filterEvents(snapshot.data ?? []));
          },
        ),
      ],
    );
  }

  List<EventDm> filterEvents(List<EventDm> events) {
    return _selectedCategoryId == null
        ? events
        : events
              .where((event) => event.categoryId == _selectedCategoryId)
              .toList();
  }

  Widget tapBar() {
    return EventlyTapBar(
      categories: allCategories,
      onTap: (id) {
        if (_selectedCategoryId == id) return;
        setState(() {
          _selectedCategoryId = id;
        });
      },
    );
  }

  Widget buildHeader(UserDm? user) {
    final languageProvider = context.watch<LanguageProvider>();
    final themeProvider = context.read<ThemeProvider>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                _appLocalizations.welcomeBack,
                style: AppStyles.regularTextStyle14.copyWith(
                  color: _theme.colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                user?.name ?? _appLocalizations.guest,
                style: AppStyles.mediumTextStyle20.copyWith(
                  color: _theme.colorScheme.onSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            GestureDetector(
              onTap: () => themeProvider.toggleThemeMode(context),
              child: SvgAsset(
                asset: themeProvider.isDarkMode(context)
                    ? AppIcons.moon
                    : AppIcons.sun,
                color: _theme.primaryColor,
              ),
            ),
            ButtonWidget(
              onTap: () {
                final newLocale = languageProvider.locale == "en" ? "ar" : "en";
                languageProvider.setLocale(newLocale);
              },
              horizontalPadding: 8,
              verticalPadding: 5.5,
              bgColor: _theme.primaryColor,
              child: Text(
                languageProvider.locale.toUpperCase(),
                style: AppStyles.semiBoldTextStyle14.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
