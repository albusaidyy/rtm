import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/shared/services/hive_service.dart';

part 'get_customers_state.dart';
part 'get_customers_cubit.freezed.dart';

class GetCustomersCubit extends Cubit<GetCustomersState> {
  GetCustomersCubit({
    required CustomerService customerService,
    required HiveService hiveService,
  })  : _customerService = customerService,
        _hiveService = hiveService,
        super(const GetCustomersState.initial()) {
    _customerService = customerService;
    _hiveService = hiveService;
  }

  late CustomerService _customerService;
  late HiveService _hiveService;

  Future<void> getCustomers() async {
    emit(const GetCustomersState.loading());
    try {
      final customers = await _customerService.getCustomers();

      // persist the customers locally
      _hiveService.persistCustomers(customers);

      emit(GetCustomersState.loaded(customers));
    } catch (e) {
      emit(const GetCustomersState.error('Oops! Something went wrong'));
    }
  }
}
