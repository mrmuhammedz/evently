import 'package:evently/models/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserDm? _user;

  UserDm? get user => _user;

  void setUser(UserDm user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void setFavorite(String eventId, bool isFavorite) {
    if (_user == null) return;

    if (!isFavorite) {
      if (!_user!.favoritesEvents.contains(eventId)) {
        _user!.favoritesEvents.add(eventId);
      }
    } else {
      _user!.favoritesEvents.remove(eventId);
    }

    notifyListeners();
  }

  void removeFavorite(String eventId) {
    if (_user == null) return;

    _user!.favoritesEvents.remove(eventId);

    notifyListeners();
  }

  bool isFavorite(String eventId) {
    if (_user == null) return false;
    return _user!.favoritesEvents.contains(eventId);
  }
}
