import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';

part 'get_activities_state.dart';
part 'get_activities_cubit.freezed.dart';

class GetActivitiesCubit extends Cubit<GetActivitiesState> {
  GetActivitiesCubit({
    required ActivityService activityService,
  })  : _activityService = activityService,
        super(const GetActivitiesState.initial()) {
    _activityService = activityService;
  }

  late ActivityService _activityService;

  Future<void> getActivities() async {
    emit(const GetActivitiesState.loading());
    try {
      final activities = await _activityService.getActivities();

      emit(GetActivitiesState.loaded(activities));
    } catch (e) {
      emit(const GetActivitiesState.error('Oops! Something went wrong'));
    }
  }
}
