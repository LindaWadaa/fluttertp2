import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:waiting_room_app/main.dart';
import 'package:waiting_room_app/queue_provider.dart';

Widget createTestApp() {
  return ChangeNotifierProvider(
    create: (_) => QueueProvider(),
    child: const WaitingRoomApp(),
  );
}

void main() {
  testWidgets('waiting room screen renders and adds a client', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestApp());

    expect(find.text('Local Waiting Room'), findsOneWidget);
    expect(find.text('Clients in Queue: 0'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(find.text('Clients in Queue: 1'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets(
    'should remove the first client from the list when "Next Client" is tapped',
    (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());

      await tester.enterText(find.byType(TextField), 'Client A');
      await tester.tap(find.text('Add'));
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'Client B');
      await tester.tap(find.text('Add'));
      await tester.pump();

      await tester.tap(find.byKey(const Key('nextClientButton')));
      await tester.pump();

      expect(find.text('Client A'), findsNothing);
      expect(find.text('Client B'), findsOneWidget);
      expect(find.text('Clients in Queue: 1'), findsOneWidget);
    },
  );
}
