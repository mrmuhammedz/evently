import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_tap_bar.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  EventCategory? _selectedCategoryId;
  late final Stream<List<EventDm>> _eventsStream;

  @override
  void initState() {
    super.initState();
    _eventsStream = EventService().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final user = context.watch<UserProvider>().user;

    return Column(
      children: [
        SizedBox(height: 24),
        buildHeader(appLocalizations, user),
        SizedBox(height: 24),
        tapBar(),
        SizedBox(height: 24),
        StreamBuilder<List<EventDm>>(
          stream: _eventsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error.toString()}'));
            } else if (!snapshot.hasData ||
                filterEvents(snapshot.data ?? []).isEmpty) {
              return Center(child: Text(appLocalizations.noEventsFound));
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

  EventlyTapBar tapBar() {
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

  Widget buildHeader(AppLocalizations appLocalizations, UserDm? user) {
    final languageProvider = context.watch<LanguageProvider>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                appLocalizations.welcomeBack,
                style: AppStyles.secText14regular,
              ),
              Text(
                user?.name ?? appLocalizations.guest,
                style: AppStyles.mainText20medium,
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
            SvgPicture.asset(AppIcons.sun),
            ButtonWidget(
              onTap: () {
                final newLocale = languageProvider.locale.languageCode == "en"
                    ? const Locale("ar")
                    : const Locale("en");
                languageProvider.setLocale(newLocale);
              },
              horizontalPadding: 8,
              verticalPadding: 5.5,
              bgColor: AppColors.mainColor,
              child: Text(
                languageProvider.locale.languageCode.toUpperCase(),
                style: AppStyles.white14semiBold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
