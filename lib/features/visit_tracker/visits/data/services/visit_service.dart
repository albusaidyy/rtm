import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class VisitService {
  Future<List<Visit>> getVisits();
  // Other visit services like create, update, delete, etc.
  Future<String> createVisit(Visit visit);
}

class VisitServiceImpl implements VisitService {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Visit>> getVisits() async {
    try {
      final response = await supabase.from('visits').select();

      final visitsList = (response as List)
          .map((json) => Visit.fromJson(json as Map<String, dynamic>))
          .toList();
      return visitsList;
    } on Exception catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<String> createVisit(Visit visit) async {
    try {
      await supabase.from('visits').insert(visit.toJson());
      return 'Visit created successfully';
    } on Exception catch (_) {
      rethrow;
    }
  }
}
