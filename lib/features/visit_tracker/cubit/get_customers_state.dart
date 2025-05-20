part of 'get_customers_cubit.dart';

@freezed
sealed class GetCustomersState with _$GetCustomersState {
  const factory GetCustomersState.initial() = _Initial;
  const factory GetCustomersState.loading() = _Loading;
  const factory GetCustomersState.loaded(List<Customer> customers) = _Loaded;
  const factory GetCustomersState.error(String message) = _Error;
}
