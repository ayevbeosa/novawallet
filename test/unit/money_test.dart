import 'package:flutter_test/flutter_test.dart';
import 'package:novawallet/core/money/money.dart';
import 'package:novawallet/core/money/money_input_parser.dart';

void main() {
  group('Money', () {
    test('formats kobo into grouped Naira with a fixed two-decimal tail', () {
      expect(const Money.fromKobo(18234050).format(), '₦182,340.50');
      expect(const Money.fromKobo(500).format(), '₦5.00');
      expect(const Money.fromKobo(5).format(), '₦0.05');
      expect(Money.zero.format(), '₦0.00');
    });

    test('formats negative amounts with the sign before the symbol', () {
      expect(const Money.fromKobo(-150).format(), '-₦1.50');
    });

    test('arithmetic stays exact across many small additions', () {
      // 10,000 additions of 1 kobo must equal exactly 100 Naira — this is
      // the case where naive double math (0.01 + 0.01 + ...) visibly drifts.
      var total = Money.zero;
      for (var i = 0; i < 10000; i++) {
        total += const Money.fromKobo(1);
      }
      expect(total.kobo, 10000);
      expect(total.format(), '₦100.00');
    });

    test('fromNaira rounds to the nearest kobo', () {
      expect(Money.fromNaira(10.1).kobo, 1010);
      expect(Money.fromNaira(182340.5).kobo, 18234050);
    });

    test('progressTowards is exact at common fractions that trip up doubles', () {
      // 1/3 of a target: naive double division famously isn't exact.
      const target = Money.fromKobo(300);
      expect(const Money.fromKobo(100).progressTowards(target), closeTo(1 / 3, 0.0001));
      expect(const Money.fromKobo(300).progressTowards(target), 1.0);
      expect(const Money.fromKobo(450).progressTowards(target), 1.0); // clamped
      expect(Money.zero.progressTowards(target), 0.0);
    });

    test('progressTowards guards a zero target instead of dividing by zero', () {
      expect(const Money.fromKobo(500).progressTowards(Money.zero), 0.0);
    });

    test('comparison and equality operate on kobo, not a derived double', () {
      expect(const Money.fromKobo(100) < const Money.fromKobo(101), isTrue);
      expect(const Money.fromKobo(100), const Money.fromKobo(100));
      expect(const Money.fromKobo(100).hashCode, const Money.fromKobo(100).hashCode);
    });
  });

  group('parseNairaInputToKobo', () {
    test('parses a whole number as Naira, not kobo', () {
      expect(parseNairaInputToKobo('5000'), 500000);
    });

    test('parses decimals without floating point drift', () {
      expect(parseNairaInputToKobo('10.1'), 1010);
      expect(parseNairaInputToKobo('0.1'), 10);
      expect(parseNairaInputToKobo('0.01'), 1);
    });

    test('strips thousands separators', () {
      expect(parseNairaInputToKobo('182,340.50'), 18234050);
    });

    test('pads a single decimal digit and truncates beyond two', () {
      expect(parseNairaInputToKobo('5.5'), 550);
      expect(parseNairaInputToKobo('5.999'), 599);
    });

    test('rejects unparsable input', () {
      expect(parseNairaInputToKobo(''), isNull);
      expect(parseNairaInputToKobo('abc'), isNull);
      expect(parseNairaInputToKobo('1.2.3'), isNull);
    });

    test('treats a leading-dot amount as zero Naira and some kobo', () {
      expect(parseNairaInputToKobo('.50'), 50);
    });
  });
}
