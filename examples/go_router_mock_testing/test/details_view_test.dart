import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_mock_testing/details_view.dart';
import 'package:mocktail/mocktail.dart';

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
    expect(find.byType(BackButton), findsOneWidget);
  });

  testWidgets('should navigate to home when back button is tapped', (
    tester,
  ) async {
    // Create a mock GoRouter instance
    final mockGoRouter = MockGoRouter();

    // Stub the go method
    when(() => mockGoRouter.go(any())).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const DetailsView(),
        ),
      ),
    );

    // Find and tap the back button
    final backButton = find.byType(BackButton);
    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Verify that go was called with '/' (home route)
    verify(() => mockGoRouter.go('/')).called(1);
  });
}
