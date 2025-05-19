part of 'get_activities_cubit.dart';

@freezed
sealed class GetActivitiesState with _$GetActivitiesState {
  const factory GetActivitiesState.initial() = _Initial;
  const factory GetActivitiesState.loading() = _Loading;
  const factory GetActivitiesState.loaded(List<Activity> activities) = _Loaded;
  const factory GetActivitiesState.error(String message) = _Error;
}
