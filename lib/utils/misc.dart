import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/utils/color_palette.dart';

class Misc {
  static String formatDate(String? date) {
    if (date == null) {
      return 'No date available';
    }
    return DateFormat('EEEE, MMMM d, yyyy - hh:mm a')
        .format(DateTime.parse(date));
  }

  static double getStatusWidthFactor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return 1;
      case 'pending':
        return 0.5;
      case 'cancelled':
        return 0.25;
      default:
        return 0;
    }
  }

  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return AppTheme.kCompletedColor;
      case 'pending':
        return AppTheme.kPendingColor;
      case 'cancelled':
        return AppTheme.kCancelledColor;
      default:
        return Colors.transparent;
    }
  }

  static int countStatus(List<Visit> visits, String status) {
    return visits
        .where((v) => v.status.toLowerCase() == status.toLowerCase())
        .length;
  }

  static double getStatusPercent(List<Visit> visits, String status) {
    final total = visits.length;
    if (total == 0) return 0;
    final count = countStatus(visits, status);
    return (count / total) * 100;
  }
}
