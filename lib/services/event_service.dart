import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';
import 'package:evently/models/user_dm.dart';

class EventService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addEvent({
    required String userId,
    required String title,
    required String description,
    required EventCategory categoryId,
    required DateTime dateTime,
  }) async {
    final eventRef = _firestore.collection('events').doc();
    final event = EventDm(
      id: eventRef.id,
      userId: userId,
      title: title,
      description: description,
      categoryId: categoryId,
      dateTime: dateTime,
    );

    await eventRef.set(event.toJson());
  }

  Stream<List<EventDm>> getEvents() {
    final querySnapshots = _firestore.collection('events').snapshots();
    return querySnapshots.map(
      (snapshot) =>
          snapshot.docs.map((doc) => EventDm.fromJson(doc.data())).toList(),
    );
  }

  Future<void> addEventToFavorites(UserDm user) async {
    final userRef = _firestore.collection('users').doc(user.id);
    await userRef.update({'favoritesEvents': user.favoritesEvents});
  }

  Future<void> deleteEvent(String eventId) async {
    final usersSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('favoritesEvents', arrayContains: eventId)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final user in usersSnapshot.docs) {
      batch.update(user.reference, {
        'favoritesEvents': FieldValue.arrayRemove([eventId]),
      });
    }

    await batch.commit();

    await _firestore.collection("events").doc(eventId).delete();
  }

  // Future<void> updateEvent() async {}
}
