import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/shared/models/local/_index.dart';
import 'package:rtm/utils/rtm_config.dart';

abstract class HiveService {
  Future<void> initBoxes();
  Future<void> clearPrefs();
  Future<void> resetDatabase();

  void setAuthData(AuthenticatedUser user);
  AuthenticatedUser? getAuthData();

  void persistVisits(List<Visit> visits);
  List<Visit> getVisits();
  void clearVisits();

  void persistCustomers(List<Customer> customers);
  List<Customer> getCustomers();
  void clearCustomers();

  void persistActivities(List<Activity> activities);
  List<Activity> getActivities();
  void clearActivities();

  void persistVisitDetails(Visit visitDetails);
  Visit getVisitDetails();
  void clearVisitDetails();
}

class HiveServiceImpl implements HiveService {
  HiveServiceImpl({String? hiveDBKey}) {
    _hiveDBKey = hiveDBKey ?? RtmConfig.instance!.values.hiveDBKey;
  }

  late String _hiveDBKey;

  @override
  Future<void> initBoxes() async {
    await Hive.initFlutter(_hiveDBKey);
    // auth
    Hive
      // ..registerAdapter(AuthenticatedUserAdapter())
      ..registerAdapter(VisitAdapter())
      ..registerAdapter(CustomerAdapter())
      ..registerAdapter(ActivityAdapter());

    if (!Hive.isBoxOpen(_hiveDBKey)) {
      await Hive.openBox<dynamic>(_hiveDBKey);
    }
  }

  @override
  Future<void> clearPrefs() async {
    await Hive.box<dynamic>(_hiveDBKey).clear();
  }

  @override
  Future<void> resetDatabase() async {
    final appDir = await getApplicationDocumentsDirectory();
    final hiveDb = Directory('${appDir.path}/$_hiveDBKey/');
    await hiveDb.delete(recursive: true);

    await initBoxes();
  }

  @override
  void setAuthData(AuthenticatedUser user) {
    Hive.box<dynamic>(_hiveDBKey).put('user', user);
  }

  @override
  AuthenticatedUser? getAuthData() {
    final box = Hive.box<dynamic>(_hiveDBKey);
    return box.get('user') as AuthenticatedUser?;
  }

  @override
  void persistVisits(List<Visit> visits) {
    Hive.box<dynamic>(_hiveDBKey).put('remote_visits', visits);
  }

  @override
  List<Visit> getVisits() {
    return Hive.box<dynamic>(_hiveDBKey).get('remote_visits') as List<Visit>;
  }

  @override
  void clearVisits() {
    Hive.box<dynamic>(_hiveDBKey).delete('remote_visits');
  }

  @override
  void persistCustomers(List<Customer> customers) {
    Hive.box<dynamic>(_hiveDBKey).put('remote_customers', customers);
  }

  @override
  List<Customer> getCustomers() {
    return Hive.box<dynamic>(_hiveDBKey).get('remote_customers')
        as List<Customer>;
  }

  @override
  void clearCustomers() {
    Hive.box<dynamic>(_hiveDBKey).delete('remote_customers');
  }

  @override
  void persistActivities(List<Activity> activities) {
    Hive.box<dynamic>(_hiveDBKey).put('remote_activities', activities);
  }

  @override
  List<Activity> getActivities() {
    return Hive.box<dynamic>(_hiveDBKey).get('remote_activities')
        as List<Activity>;
  }

  @override
  void clearActivities() {
    Hive.box<dynamic>(_hiveDBKey).delete('remote_activities');
  }

  @override
  void persistVisitDetails(Visit visitDetails) {
    Hive.box<dynamic>(_hiveDBKey).put('visit_details', visitDetails);
  }

  @override
  Visit getVisitDetails() {
    return Hive.box<dynamic>(_hiveDBKey).get('visit_details') as Visit;
  }

  @override
  void clearVisitDetails() {
    Hive.box<dynamic>(_hiveDBKey).delete('visit_details');
  }
}
