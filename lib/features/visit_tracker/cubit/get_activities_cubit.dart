import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/shared/services/hive_service.dart';

part 'get_activities_state.dart';
part 'get_activities_cubit.freezed.dart';

class GetActivitiesCubit extends Cubit<GetActivitiesState> {
  GetActivitiesCubit({
    required ActivityService activityService,
    required HiveService hiveService,
  })  : _activityService = activityService,
        _hiveService = hiveService,
        super(const GetActivitiesState.initial()) {
    _activityService = activityService;
    _hiveService = hiveService;
  }

  late ActivityService _activityService;
  late HiveService _hiveService;

  Future<void> getActivities() async {
    emit(const GetActivitiesState.loading());
    try {
      final activities = await _activityService.getActivities();

      // persist the activities locally
      _hiveService.persistActivities(activities);

      emit(GetActivitiesState.loaded(activities));
    } catch (e) {
      emit(const GetActivitiesState.error('Oops! Something went wrong'));
    }
  }
}
