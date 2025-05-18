import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';

abstract class VisitService {
  Future<Visits> getVisits();
}

class VisitServiceImpl implements VisitService {
  @override
  Future<Visits> getVisits() async {
    try {
      return Visits(visits: []);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
