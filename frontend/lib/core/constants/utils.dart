import 'dart:ui';

/// Increase or decrease color intensity
Color strengthenColor(Color color, double factor) {
  final r = (color.r * factor).clamp(0.0, 1.0);
  final g = (color.g * factor).clamp(0.0, 1.0);
  final b = (color.b * factor).clamp(0.0, 1.0);

  return Color.fromRGBO(
    (r * 255).round(),
    (g * 255).round(),
    (b * 255).round(),
    color.a,
  );
}

/// Generate dates for a given week offset
List<DateTime> generateWeekDates(int weekOffset) {
  final today = DateTime.now();
  final startOfWeek = today.subtract(
    Duration(days: today.weekday - 1 + (weekOffset * 7)),
  );

  return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
}

/// Convert Color → hex string (RRGGBB)
String rgbToHex(Color color) {
  final r = (color.r * 255).round();
  final g = (color.g * 255).round();
  final b = (color.b * 255).round();

  return r.toRadixString(16).padLeft(2, '0') +
      g.toRadixString(16).padLeft(2, '0') +
      b.toRadixString(16).padLeft(2, '0');
}

/// Convert hex string (RRGGBB or AARRGGBB) → Color
/// Convert hex string (RRGGBB or AARRGGBB) → Color
Color hexToRgb(String hex) {
  final normalized = hex.replaceFirst('#', '');
  final value = int.parse(normalized, radix: 16);

  return normalized.length == 6 ? Color(0xFF000000 | value) : Color(value);
}
