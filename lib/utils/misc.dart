import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/utils/color_palette.dart';

class Misc {
  static String formatDate(String? date) {
    if (date == null || date.isEmpty) {
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

  static int countStatus(List<CustomerVisit> visits, String status) {
    return visits
        .where((v) => v.status.toLowerCase() == status.toLowerCase())
        .length;
  }

  static double getStatusPercent(List<CustomerVisit> visits, String status) {
    final total = visits.length;
    if (total == 0) return 0;
    final count = countStatus(visits, status);
    return (count / total) * 100;
  }

  static List<CustomerVisit> mapVisists({
    required List<Visit> visits,
    required List<Customer> customers,
    required List<Activity> activities,
  }) {
    return visits.map((visit) {
      final customer =
          customers.firstWhere((customer) => customer.id == visit.customerId);

      final activitiesDone = visit.activitiesDone
              ?.map(
                (activityId) => activities
                    .firstWhere(
                      (activity) => activity.id == int.parse(activityId),
                    )
                    .description,
              )
              .toList() ??
          <String>[];

      return CustomerVisit(
        id: visit.id,
        customerName: customer.name,
        status: visit.status,
        location: visit.location,
        activitiesDone: activitiesDone,
        visitDate: visit.visitDate ?? '',
        notes: visit.notes ?? '',
        createdAt: visit.createdAt ?? '',
      );
    }).toList();
  }
}
