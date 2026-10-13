import 'package:flutter/foundation.dart';

class QueueProvider extends ChangeNotifier {
  final List<String> _clients = [];

  List<String> get clients => List.unmodifiable(_clients);

  void addClient(String name) {
    _clients.add(name);
    notifyListeners();
  }

  void removeClient(String name) {
    if (_clients.remove(name)) {
      notifyListeners();
    }
  }

  void removeClientAt(int index) {
    if (index < 0 || index >= _clients.length) {
      return;
    }

    _clients.removeAt(index);
    notifyListeners();
  }

  void nextClient() {
    if (_clients.isEmpty) {
      return;
    }

    _clients.removeAt(0);
    notifyListeners();
  }
}
