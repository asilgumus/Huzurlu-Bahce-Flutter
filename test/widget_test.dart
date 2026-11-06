import 'package:flutter_test/flutter_test.dart';

import 'package:huzurlu_bahce/main.dart';

void main() {
  testWidgets('main menu renders', (WidgetTester tester) async {
    await tester.pumpWidget(const HuzurluBahceApp());
    await tester.pumpAndSettle();

    expect(find.text('Huzurlu Bahçe'), findsOneWidget);
  });
}
