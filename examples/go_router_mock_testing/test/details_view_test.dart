import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_mock_testing/details_view.dart';

import 'helpers/mock_go_router_provider.dart';
import 'mocks/mock_go_router.dart';

void main() {
  testWidgets('should display details screen with all UI elements', (
    tester,
  ) async {
    // Create a mock GoRouter instance
    final mockGoRouter = MockGoRouter();

    await tester.pumpWidget(
      MaterialApp(
        home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const DetailsView(),
        ),
      ),
    );

    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Details View'), findsOneWidget);
    expect(find.text('This is a placeholder screen'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });
}
