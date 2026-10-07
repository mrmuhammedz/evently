import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<EventDm> events;

  const EventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: events.length,
        itemBuilder: (_, index) => EventCard(
          events: events,
          index: index,
        ),
        separatorBuilder: (_, _) => SizedBox(height: 16),
      ),
    );
  }
}
