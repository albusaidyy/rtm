import 'package:rtm/features/visit_tracker/data/models/activity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ActivityService {
  Future<List<Activity>> getActivities();
  // Other visit services like create, update, delete, etc.
  Future<String> createActivity(Activity activity);
}

class ActivityServiceImpl implements ActivityService {
  final supabase = Supabase.instance.client;

  @override
  Future<List<Activity>> getActivities() async {
    try {
      final response = await supabase.from('activities').select();

      final activitiesList = (response as List)
          .map((json) => Activity.fromJson(json as Map<String, dynamic>))
          .toList();
      return activitiesList;
    } on Exception catch (e, _) {
      rethrow;
    }
  }

  @override
  Future<String> createActivity(Activity activity) async {
    try {
      await supabase.from('activities').insert(activity.toJson());
      return 'Activity created successfully';
    } on Exception catch (_) {
      rethrow;
    }
  }
}
