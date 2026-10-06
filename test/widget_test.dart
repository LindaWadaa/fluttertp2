import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/main.dart';

void main() {
  testWidgets('Waiting room screen renders and adds a client', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const WaitingRoomApp());

    expect(find.text('Local Waiting Room'), findsOneWidget);
    expect(find.text('Clients in Queue: 0'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(find.text('Clients in Queue: 1'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
  });
}
