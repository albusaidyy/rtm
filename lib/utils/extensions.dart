import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension OpacityParsing on Color {
  // .addOpacity() has been depreciated
  // The propesed replacement .withValues(alpha: ) has a max of 255
  // Hence this extension method retains the scale of 0 to 1
  Color addOpacity(double opacity) {
    if (opacity >= 0.0 && opacity <= 1.0) {
      return withAlpha((255.0 * opacity).round());
    }
    return this;
  }
}

extension DateTimeExtensions on DateTime {
  /// Returns a formatted string of the date in the format 'MMMM d, y'.
  /// Suitable for display purposes
  String toDateDisplayFormat() =>
      DateFormat('EEEE, MMMM d, yyyy - hh:mm a').format(this);
}

extension StringExtensions on String {
  /// Returns a formatted string of the date
  /// in the format 'yyyy-MM-ddTHH:mm:ss.SSSZ'
  String toIso8601String() =>
      DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(this).toIso8601String();

  /// Returns a formatted string of the date
  /// in the format 'EEEE, MMMM d, yyyy - hh:mm a'
  String toIso8601StringFromDisplay() {
    if (trim().isEmpty) return '';
    return DateFormat('EEE, MMMM d, yyyy - hh:mm a')
        .parse(this)
        .toIso8601String();
  }
}
