import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/services/visit_service.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/shared/services/customer_services.dart';

part 'get_visits_state.dart';
part 'get_visits_cubit.freezed.dart';

class GetVisitsCubit extends Cubit<GetVisitsState> {
  GetVisitsCubit({
    required VisitService visitService,
    required CustomerService customerService,
  })  : _visitService = visitService,
        _customerService = customerService,
        super(const GetVisitsState.initial()) {
    _visitService = visitService;
    _customerService = customerService;
  }

  late VisitService _visitService;
  late CustomerService _customerService;

  Future<void> getVisits() async {
    emit(const GetVisitsState.loading());
    try {
      final visits = await _visitService.getVisits();

      final customers = await _customerService.getCustomers();

      final customerVisits = visits.map((visit) {
        final customer =
            customers.firstWhere((customer) => customer.id == visit.customerId);
        return CustomerVisit(
          id: visit.id,
          customerName: customer.name,
          status: visit.status,
          location: visit.location,
          activitiesDone: visit.activitiesDone ?? [],
          visitDate: visit.visitDate ?? '',
          notes: visit.notes ?? '',
          createdAt: visit.createdAt ?? '',
        );
      }).toList();

      emit(GetVisitsState.loaded(customerVisits));
    } catch (e) {
      emit(const GetVisitsState.error('Oops! Something went wrong'));
    }
  }
}
