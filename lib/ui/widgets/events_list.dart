import 'package:evently/models/event_dm.dart';
import 'package:evently/ui/widgets/event_card.dart';
import 'package:flutter/material.dart';

class EventsList extends StatelessWidget {
  final List<EventDm> events;
  final String heroTag;

  const EventsList({super.key, required this.events, required this.heroTag,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: events.length,
        itemBuilder: (_, index) => EventCard(
          event: events[index],
          heroTag: "$heroTag${events[index].id}",
        ),
        separatorBuilder: (_, _) => const SizedBox(height: 16),
      ),
    );
  }
}
