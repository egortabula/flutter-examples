import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router_mock_testing/home_view.dart';
import 'package:mocktail/mocktail.dart';

import 'helpers/mock_go_router_provider.dart';
import 'mocks/mock_go_router.dart';

void main() {
  group('UI Tests', () {
    testWidgets('should display home screen with all UI elements', (
      tester,
    ) async {
      // Create a mock GoRouter instance
      final mockGoRouter = MockGoRouter();

      // Stub canPop to return false (no navigation history)
      when(() => mockGoRouter.canPop()).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Check app bar title
      expect(find.text('GoRouter Testing Example'), findsWidgets);

      // Check info banner
      expect(
        find.text(
          'To learn how to mock GoRouter for testing, check the /test folder',
        ),
        findsOneWidget,
      );

      // Check section headers (visible ones)
      expect(find.text('Navigation Methods'), findsOneWidget);
      expect(find.text('Stack Methods'), findsOneWidget);

      // Check navigation method cards (visible ones)
      expect(find.text('go()'), findsOneWidget);
      expect(find.text('goNamed()'), findsOneWidget);
      expect(find.text('push()'), findsOneWidget);
      expect(find.text('pushNamed()'), findsOneWidget);

      // Scroll down to check more elements
      await tester.dragUntilVisible(
        find.text('pop()'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      expect(find.text('pop()'), findsOneWidget);

      // Check Generic Methods section
      await tester.dragUntilVisible(
        find.text('Generic Methods'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      expect(find.text('Generic Methods'), findsOneWidget);
      expect(find.text('push<bool>()'), findsOneWidget);
      expect(find.text('pop<String>()'), findsOneWidget);

      // Check Replacement Methods section
      await tester.dragUntilVisible(
        find.text('Replacement Methods'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      expect(find.text('Replacement Methods'), findsOneWidget);
      expect(find.text('pushReplacement()'), findsOneWidget);
      expect(find.text('pushReplacementNamed()'), findsOneWidget);

      // Scroll to last elements
      await tester.dragUntilVisible(
        find.text('replace()'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      expect(find.text('replace()'), findsOneWidget);

      await tester.dragUntilVisible(
        find.text('replaceNamed()'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      expect(find.text('replaceNamed()'), findsOneWidget);
    });
  });

  group('Navigation Tests', () {
    late MockGoRouter mockGoRouter;

    setUp(() {
      mockGoRouter = MockGoRouter();
      // Stub canPop for all navigation tests
      when(() => mockGoRouter.canPop()).thenReturn(true);
    });

    testWidgets('should call go() when tapped', (tester) async {
      // Stub the method
      when(() => mockGoRouter.go(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Find and tap the card
      await tester.tap(find.text('go()'));
      await tester.pumpAndSettle();

      // Verify the method was called
      verify(() => mockGoRouter.go('/details')).called(1);
    });

    testWidgets('should call goNamed() when tapped', (tester) async {
      // Stub the method
      when(() => mockGoRouter.goNamed(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      await tester.tap(find.text('goNamed()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.goNamed('details')).called(1);
    });

    testWidgets('should call push() when tapped', (tester) async {
      // Stub the method
      when(() => mockGoRouter.push(any())).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      await tester.tap(find.text('push()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.push('/details')).called(1);
    });

    testWidgets('should call pushNamed() when tapped', (tester) async {
      // Stub the method
      when(() => mockGoRouter.pushNamed(any())).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      await tester.tap(find.text('pushNamed()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.pushNamed('details')).called(1);
    });

    testWidgets('should call pop() when tapped and can pop', (tester) async {
      // Stub the method
      when(() => mockGoRouter.pop()).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('pop()'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('pop()'));
      await tester.pumpAndSettle();

      // Verify that canPop was checked before calling pop
      verify(() => mockGoRouter.canPop()).called(greaterThan(0));
      verify(() => mockGoRouter.pop()).called(1);
    });

    testWidgets('should call push<bool>() when tapped', (tester) async {
      // Stub the method with generic type
      when(() => mockGoRouter.push<bool>(any())).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('push<bool>()'),
        find.byType(CustomScrollView),
        const Offset(0, -100),
      );

      await tester.tap(find.text('push<bool>()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.push<bool>('/details')).called(1);
    });

    testWidgets('should call pop<String>() when tapped', (tester) async {
      // Stub the method with generic type
      when(() => mockGoRouter.pop<String>(any())).thenReturn(null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('pop<String>()'),
        find.byType(CustomScrollView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle();

      await tester.tap(
        find.text('pop<String>()', skipOffstage: false),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      // Verify that canPop was checked before calling pop
      verify(() => mockGoRouter.canPop()).called(greaterThan(0));
      verify(() => mockGoRouter.pop<String>('Result from Home')).called(1);
    });

    testWidgets('should call pushReplacement() when tapped', (tester) async {
      // Stub the method
      when(
        () => mockGoRouter.pushReplacement(any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('pushReplacement()'),
        find.byType(CustomScrollView),
        const Offset(0, -100),
      );

      await tester.tap(find.text('pushReplacement()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.pushReplacement('/details')).called(1);
    });

    testWidgets('should call pushReplacementNamed() when tapped', (
      tester,
    ) async {
      // Stub the method
      when(
        () => mockGoRouter.pushReplacementNamed(any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('pushReplacementNamed()'),
        find.byType(CustomScrollView),
        const Offset(0, -100),
      );

      await tester.tap(find.text('pushReplacementNamed()'));
      await tester.pumpAndSettle();

      verify(() => mockGoRouter.pushReplacementNamed('details')).called(1);
    });

    testWidgets('should call replace() when tapped', (tester) async {
      // Stub the method to return Future
      when(
        () => mockGoRouter.replace<Object?>(any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('replace()'),
        find.byType(CustomScrollView),
        const Offset(0, -100),
      );

      await tester.tap(find.text('replace()'));
      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.replace<Object?>(any(), extra: any(named: 'extra')),
      ).called(1);
    });

    testWidgets('should call replaceNamed() when tapped', (tester) async {
      // Stub the method to return Future
      when(
        () => mockGoRouter.replaceNamed<Object?>(any()),
      ).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: MockGoRouterProvider(
            goRouter: mockGoRouter,
            child: const HomeView(),
          ),
        ),
      );

      // Need to scroll to find the card
      await tester.dragUntilVisible(
        find.text('replaceNamed()'),
        find.byType(CustomScrollView),
        const Offset(0, -100),
      );

      await tester.tap(find.text('replaceNamed()'));
      await tester.pumpAndSettle();

      verify(
        () => mockGoRouter.replaceNamed<Object?>(
          any(),
          pathParameters: any(named: 'pathParameters'),
          queryParameters: any(named: 'queryParameters'),
          extra: any(named: 'extra'),
        ),
      ).called(1);
    });
  });
}
