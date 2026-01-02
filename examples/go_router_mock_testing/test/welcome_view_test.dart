import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_mock_testing/welcome_view.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/mock_go_router_provider.dart';
import 'mocks/mock_go_router.dart';

void main() {
  testWidgets('should display welcome screen with all UI elements', (
    tester,
  ) async {
    // Create a mock GoRouter instance
    final mockGoRouter = MockGoRouter();

    await tester.pumpWidget(
      MaterialApp(
        home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const WelcomeView(),
        ),
      ),
    );

    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('GoRouter Testing Example'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.byIcon(Icons.rocket_launch), findsOneWidget);
  });

  testWidgets('should navigate to home when get started button is tapped', (
    tester,
  ) async {
    // Create a mock GoRouter instance
    final mockGoRouter = MockGoRouter();

    // Stub the push method to return null when called with '/home'
    when(() => mockGoRouter.push('/home')).thenAnswer((_) async => null);

    // Wrap WelcomeView with MockGoRouterProvider to provide mock router
    await tester.pumpWidget(
      MaterialApp(
        home: MockGoRouterProvider(
          goRouter: mockGoRouter,
          child: const WelcomeView(),
        ),
      ),
    );

    final getStartedButton = find.text('Get Started');
    expect(getStartedButton, findsOneWidget);

    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();

    // Verify that push was called exactly once with '/home'
    verify(() => mockGoRouter.push('/home')).called(1);
  });
}
