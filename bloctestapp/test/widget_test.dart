import 'package:bloctestapp/blocs/auth/auth_bloc.dart';
import 'package:bloctestapp/blocs/auth/auth_event.dart';
import 'package:bloctestapp/blocs/auth/auth_state.dart';
import 'package:bloctestapp/models/user.dart';
import 'package:bloctestapp/ui/screens/home/home_schomereen.dart';
import 'package:bloctestapp/ui/screens/home/page1.dart';
import 'package:bloctestapp/ui/screens/home/page2.dart';
import 'package:bloctestapp/ui/screens/home/page3.dart';
import 'package:bloctestapp/ui/screens/home/page4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

class FakeAuthEvent extends Fake implements AuthEvent {}

class FakeAuthState extends Fake implements AuthState {}

void main() {
  late AuthBloc authBloc;

  setUpAll(() {
    registerFallbackValue(FakeAuthEvent());
    registerFallbackValue(FakeAuthState());
  });

  setUp(() {
    authBloc = MockAuthBloc();

    // Provide a stream and initial state
    when(() => authBloc.state).thenReturn(AuthInitial());
    when(() => authBloc.stream)
        .thenAnswer((_) => Stream<AuthState>.value(AuthInitial()));
    when(() => authBloc.add(any())).thenReturn(null);
  });

  testWidgets('HomeScreen bottom nav taps and logout test',
      (WidgetTester tester) async {
    final testUser =
        User(id: '1', name: 'Test User', email: 'test@example.com');

    // Provide a default state
    when(() => authBloc.state).thenReturn(AuthInitial());

    // Now this works because fallback is registered
    when(() => authBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: authBloc,
          child: HomeScreen(user: testUser),
        ),
      ),
    );

    // Verify initial index
    expect(find.text('Welcome, Test User'), findsOneWidget);

    // Bottom nav items
    final homeItem = find.text('Home');
    final searchItem = find.text('Search');
    final notifyItem = find.text('Notify');
    final profileItem = find.text('Profile');

    // Tap each bottom nav item
    await tester.tap(searchItem);
    await tester.pump();
    expect(find.byType(Page2), findsOneWidget);

    await tester.tap(notifyItem);
    await tester.pump();
    expect(find.byType(Page3), findsOneWidget);

    await tester.tap(profileItem);
    await tester.pump();
    expect(find.byType(Page4), findsOneWidget);

    await tester.tap(homeItem);
    await tester.pump();
    expect(find.byType(Page1), findsOneWidget);

    // Tap logout
    final logoutButton = find.byIcon(Icons.logout);
    await tester.tap(logoutButton);
    await tester.pump();

    // Verify AuthBloc received LoggedOut event
    verify(() => authBloc.add(LoggedOut())).called(1);
  });
}
