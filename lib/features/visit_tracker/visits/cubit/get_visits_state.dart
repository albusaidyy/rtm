part of 'get_visits_cubit.dart';

@freezed
sealed class GetVisitsState with _$GetVisitsState {
  const factory GetVisitsState.initial() = _Initial;
  const factory GetVisitsState.loading() = _Loading;
  const factory GetVisitsState.loaded(List<CustomerVisit> visits) = _Loaded;
  const factory GetVisitsState.error(String message) = _Error;
}
