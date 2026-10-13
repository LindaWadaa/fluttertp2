class WaitingRoomManager {
  final List<String> _clients = [];

  List<String> get clients => _clients;

  void addClient(String name) {
    _clients.add(name);
  }

  void removeClient(String name) {
    _clients.remove(name);
  }

  void removeClientAt(int index) {
    if (index < 0 || index >= _clients.length) {
      return;
    }

    _clients.removeAt(index);
  }
}
