import 'package:flutter_test/flutter_test.dart';

import 'package:rickverse_app/app.dart';

void main() {
  testWidgets('RickVerse home screen loads', (WidgetTester tester) async {
    await tester.pumpWidget(const RickVerseApp());
    await tester.pumpAndSettle();

    expect(find.text('Personajes'), findsOneWidget);
    expect(find.text('Contrátame'), findsOneWidget);
    expect(find.text('Inicio'), findsOneWidget);
    expect(find.text('Juega conmigo'), findsWidgets);
  });
}
