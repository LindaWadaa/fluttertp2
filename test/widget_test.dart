import 'package:flutter_test/flutter_test.dart';
import 'package:waiting_room_app/main.dart';

void main() {
  testWidgets('MyApp renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Waiting Room'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
  });
}
