import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VisitService {
  Future<Visits> getVisits();
  Future<void> createVisit(Visit visit);
}

class VisitServiceImpl implements VisitService {
  final supabase = Supabase.instance.client;

  @override
  Future<Visits> getVisits() async {
    try {
      final response = await supabase.from('visits').select();
      return Visits(visits: response.map(Visit.fromJson).toList());
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> createVisit(Visit visit) async {
    try {
      await supabase.from('visits').insert(visit.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
