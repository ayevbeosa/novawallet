import 'package:meta/meta.dart';

/// An amount of Nigerian Naira represented as an exact integer number of
/// kobo (1 Naira = 100 kobo).
///
/// Every arithmetic operation here stays in integer kobo space. Doubles only
/// ever appear transiently inside [Money.fromNaira], which exists purely for
/// tests/seed data that are easiest to write in Naira — never in the
/// balance/progress computation path.
@immutable
class Money implements Comparable<Money> {
  const Money.fromKobo(this.kobo);

  factory Money.fromNaira(num naira) => Money.fromKobo((naira * 100).round());

  static const Money zero = Money.fromKobo(0);

  final int kobo;

  Money operator +(Money other) => Money.fromKobo(kobo + other.kobo);

  Money operator -(Money other) => Money.fromKobo(kobo - other.kobo);

  bool operator <(Money other) => kobo < other.kobo;

  bool operator <=(Money other) => kobo <= other.kobo;

  bool operator >(Money other) => kobo > other.kobo;

  bool operator >=(Money other) => kobo >= other.kobo;

  bool get isNegative => kobo < 0;

  bool get isZero => kobo == 0;

  /// Progress of this amount towards [target], clamped to [0, 1].
  ///
  /// Computed with integer division scaled by 10000 (basis points) before
  /// converting to a display double, so the comparison driving the clamp is
  /// exact even though the returned ratio is a double for the UI layer.
  double progressTowards(Money target) {
    if (target.kobo <= 0) return 0;
    final basisPoints = (kobo * 10000) ~/ target.kobo;
    return (basisPoints.clamp(0, 10000)) / 10000;
  }

  /// Formats as "₦12,345.67" using only integer arithmetic — the Naira and
  /// kobo parts are split with `~/` and `%` on [kobo], never by dividing to
  /// a double, so there is no float drift in the displayed figure.
  String format({bool withSymbol = true}) {
    final negative = kobo < 0;
    final absKobo = kobo.abs();
    final nairaPart = absKobo ~/ 100;
    final koboPart = absKobo % 100;
    final grouped = _groupThousands(nairaPart.toString());
    final koboStr = koboPart.toString().padLeft(2, '0');
    final sign = negative ? '-' : '';
    final symbol = withSymbol ? '₦' : '';
    return '$sign$symbol$grouped.$koboStr';
  }

  static String _groupThousands(String digits) {
    final buffer = StringBuffer();
    final reversed = digits.split('').reversed.toList();
    for (var i = 0; i < reversed.length; i++) {
      if (i != 0 && i % 3 == 0) buffer.write(',');
      buffer.write(reversed[i]);
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  int compareTo(Money other) => kobo.compareTo(other.kobo);

  @override
  bool operator ==(Object other) => other is Money && other.kobo == kobo;

  @override
  int get hashCode => kobo.hashCode;

  @override
  String toString() => format();
}
