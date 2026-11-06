import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/services/event_service.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/widgets/evently_text_form_field.dart';
import 'package:evently/ui/widgets/events_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTap extends StatefulWidget {
  const FavoriteTap({super.key});

  @override
  State<FavoriteTap> createState() => _FavoriteTapState();
}

class _FavoriteTapState extends State<FavoriteTap> {
  String? _searchText;
  late final Stream<List<EventDm>> _eventsStream;
  UserProvider get _userProvider => context.watch<UserProvider>();

  @override
  void initState() {
    super.initState();
    _eventsStream = EventService().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(height: 16),
        EventlyTextFormField(
          label: appLocalizations.searchForEvent,
          suffixIcon: AppIcons.search,
          suffixIconColor: Theme.of(context).primaryColor,
          textInputAction: TextInputAction.search,
          onChanged: (text) {
            setState(() {
              _searchText = text.trim().toLowerCase();
            });
          },
        ),
        SizedBox(height: 16),
        StreamBuilder<List<EventDm>>(
          stream: _eventsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                filteredEvents(snapshot.data ?? []).isEmpty) {
              return Center(child: Text(appLocalizations.noEventsFound));
            }
            return EventsList(events: filteredEvents(snapshot.data ?? []));
          },
        ),
      ],
    );
  }

  List<EventDm> filteredEvents(List<EventDm> filteredEvents) {
    final favoritesEvents = filteredEvents
        .where((event) => _userProvider.isFavorite(event.id))
        .toList();

    return _searchText == null
        ? favoritesEvents
        : favoritesEvents
              .where(
                (event) =>
                    event.title.toLowerCase().contains(_searchText!) ||
                    event.description.toLowerCase().contains(_searchText!),
              )
              .toList();
  }
}
