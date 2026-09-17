/// Parses a Naira amount typed by a user (e.g. "12,345.6") into an exact
/// integer number of kobo, entirely with string/int operations — no
/// `double.parse` anywhere on this path, so a value like "0.1" can never
/// pick up binary-floating-point drift on its way into a `Money`.
///
/// Returns `null` for anything that isn't a plausible amount. A third or
/// later decimal digit is truncated (not rounded) rather than rejected —
/// documented here and in the README as the deliberate behaviour for kobo
/// entry.
int? parseNairaInputToKobo(String input) {
  final cleaned = input.trim().replaceAll(',', '');
  if (cleaned.isEmpty) return null;

  final parts = cleaned.split('.');
  if (parts.length > 2) return null;

  final wholePart = parts[0];
  final fractionPart = parts.length == 2 ? parts[1] : '';

  if (wholePart.isEmpty && fractionPart.isEmpty) return null;
  if (wholePart.isNotEmpty && !_isDigitsOnly(wholePart)) return null;
  if (fractionPart.isNotEmpty && !_isDigitsOnly(fractionPart)) return null;

  final naira = wholePart.isEmpty ? 0 : int.parse(wholePart);
  final koboFraction = fractionPart.padRight(2, '0').substring(0, 2);
  final kobo = int.parse(koboFraction);

  return naira * 100 + kobo;
}

bool _isDigitsOnly(String value) => RegExp(r'^\d+$').hasMatch(value);
