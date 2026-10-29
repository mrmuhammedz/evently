import 'package:evently/models/user_dm.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserDm? _user;

  UserDm? get user => _user;

  void setUser(UserDm user) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  void updateFavorites(String eventId) {
    if (_user == null) return;
    if (_user!.favoritesEvents.contains(eventId)) {
      _user!.favoritesEvents.remove(eventId);
    } else {
      _user!.favoritesEvents.add(eventId);
    }
    notifyListeners();
  }

  bool isFavorite(String eventId) {
    if (_user == null) return false;
    return _user!.favoritesEvents.contains(eventId);
  }
}
