// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scenario_maker_app/ui/screens/scenario_generation/components/generate_scenario_tile.dart';


void main() {
  group('GenerateScenarioTile tests', () {
    testWidgets('GenerateScenarioTile triggers onTap callback when tapped',
        (WidgetTester tester) async {
      bool tapped = false;
      const backgroundColor = Colors.blue;
      const iconBackgroundColor = Colors.green;
      const assetPath = 'assets/icons/icon.png'; // Заметьте, картинка должна существовать!
      const title = 'Test Title';
      const description = 'Test Description';

      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light(), // Удобно задать тему, чтобы видеть текстовые стили
        home: Center(
          child: GenerateScenarioTile(
            backgroundColor: backgroundColor,
            iconBackgroundColor: iconBackgroundColor,
            assetPath: assetPath,
            title: title,
            description: description,
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ));

      // Утверждаем, что изначально не произошло нажатия
      expect(tapped, equals(false));

      // Моделируем тап по виджету
      await tester.tap(find.byType(GenerateScenarioTile));
      await tester.pumpAndSettle(); // Ждём завершение всех анимаций

      // Проверяем, что обработчик сработал
      expect(tapped, equals(true));
    });
  });
}