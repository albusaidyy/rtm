import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';

part 'get_customers_state.dart';
part 'get_customers_cubit.freezed.dart';

class GetCustomersCubit extends Cubit<GetCustomersState> {
  GetCustomersCubit({
    required CustomerService customerService,
  })  : _customerService = customerService,
        super(const GetCustomersState.initial()) {
    _customerService = customerService;
  }

  late CustomerService _customerService;

  Future<void> getCustomers() async {
    emit(const GetCustomersState.loading());
    try {
      final customers = await _customerService.getCustomers();

      emit(GetCustomersState.loaded(customers));
    } catch (e) {
      emit(const GetCustomersState.error('Oops! Something went wrong'));
    }
  }
}
