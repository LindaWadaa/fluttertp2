import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiting_room_app/queue_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QueueProvider(),
      child: const WaitingRoomApp(),
    ),
  );
}

class WaitingRoomApp extends StatelessWidget {
  const WaitingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: WaitingRoomScreen());
  }
}

class WaitingRoomScreen extends StatelessWidget {
  const WaitingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queueProvider = context.watch<QueueProvider>();
    final controller = TextEditingController();

    void addClient() {
      final clientName = controller.text.trim();
      if (clientName.isEmpty) {
        return;
      }

      context.read<QueueProvider>().addClient(clientName);
      controller.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Waiting Room'),
        actions: [
          IconButton(
            key: const Key('nextClientButton'),
            icon: const Icon(Icons.skip_next),
            onPressed: context.read<QueueProvider>().nextClient,
            tooltip: 'Next Client',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Client Name'),
                    onSubmitted: (_) => addClient(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: addClient, child: const Text('Add')),
              ],
            ),
            const SizedBox(height: 16),
            Text('Clients in Queue: ${queueProvider.clients.length}'),
            Expanded(
              child: ListView.builder(
                itemCount: queueProvider.clients.length,
                itemBuilder: (context, index) {
                  final clientName = queueProvider.clients[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(clientName)),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            key: ValueKey('remove-client-$index'),
                            onPressed: () => context
                                .read<QueueProvider>()
                                .removeClientAt(index),
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
