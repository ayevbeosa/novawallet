import 'package:flutter_test/flutter_test.dart';

/// A bounded stand-in for `pumpAndSettle()`.
///
/// A focused `TextField`'s cursor-blink `AnimationController` repeats
/// indefinitely, which makes `pumpAndSettle()` hang forever the moment any
/// screen in this app has a focused text field on screen (every step of
/// Send Money / Contribute does). Two bounded pumps are enough for our
/// cubits — state changes propagate synchronously (`bloc_signals`) and the
/// fake backend has zero simulated latency in tests — without waiting on
/// an animation that never settles.
Future<void> settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
}
