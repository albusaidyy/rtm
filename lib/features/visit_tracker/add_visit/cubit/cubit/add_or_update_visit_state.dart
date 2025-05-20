part of 'add_or_update_visit_cubit.dart';

@freezed
class AddOrUpdateVisitState with _$AddOrUpdateVisitState {
  const factory AddOrUpdateVisitState.initial() = _Initial;
  const factory AddOrUpdateVisitState.loading() = _Loading;
  const factory AddOrUpdateVisitState.success({@Default(false) bool isEdit}) =
      _Success;
  const factory AddOrUpdateVisitState.error(String message) = _Error;
}
