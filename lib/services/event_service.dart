import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_dm.dart';
import 'package:evently/models/event_dm.dart';

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

  Stream<List<EventDm>> getFavoriteEvents(List<String> favorites) {
    if (favorites.isEmpty) {
      return Stream.value([]);
    }

    final safeIds = favorites.take(30).toList();

    return _firestore
        .collection('events')
        .where(FieldPath.documentId, whereIn: safeIds)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => EventDm.fromJson(doc.data())).toList(),
        );
  }

  Stream<List<EventDm>> getMyEvents(String userId) {
    return _firestore
        .collection('events')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => EventDm.fromJson(doc.data())).toList(),
        );
  }

  Future<void> updateFavorite({
    required String userId,
    required String eventId,
    required bool isFavorite,
  }) async {
    final userRef = _firestore.collection('users').doc(userId);

    await userRef.update({
      'favoritesEvents': !isFavorite
          ? FieldValue.arrayUnion([eventId])
          : FieldValue.arrayRemove([eventId]),
    });
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

  Future<void> updateEvent(EventDm updatedEvent) async {
    final eventRef = _firestore.collection('events').doc(updatedEvent.id);

    await eventRef.update(updatedEvent.toJson());
  }
}
