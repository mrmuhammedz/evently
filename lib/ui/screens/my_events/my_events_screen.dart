import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  late final Stream<List<EventDm>> _eventsStream;
  UserDm? get _user => context.watch<UserProvider>().user;
  ThemeData get _theme => Theme.of(context);
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _eventsStream = EventService().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return EventlyScaffold(
      child: Column(
        children: [
          SizedBox(height: 16),
          screenHeader(),
          SizedBox(height: 16),
          StreamBuilder<List<EventDm>>(
            stream: _eventsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  filteredEvents(snapshot.data!).isEmpty) {
                return Center(child: Text(_appLocalizations.noEventsFound));
              }
              return EventsList(
                events: filteredEvents(snapshot.data!),
                heroTag: 'my_events_',
              );
            },
          ),
        ],
      ),
    );
  }

  EventlyHeader screenHeader() {
    return EventlyHeader(
      center: Text(
        _appLocalizations.myEvents,
        style: AppStyles.mediumTextStyle18.copyWith(
          color: _theme.colorScheme.onSecondary,
        ),
      ),
      leading: ButtonWidget(
        onTap: () => Navigator.pop(context),
        child: SvgAsset(
          asset: Localizations.localeOf(context).languageCode == "en"
              ? AppIcons.arrowLeft
              : AppIcons.arrowRight,
          color: _theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  List<EventDm> filteredEvents(List<EventDm> filteredEvents) {
    return filteredEvents.where((event) => event.userId == _user?.id).toList();
  }
}
