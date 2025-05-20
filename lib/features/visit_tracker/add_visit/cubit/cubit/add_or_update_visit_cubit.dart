import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:rtm/features/visit_tracker/visits/data/services/visit_service.dart';
import 'package:rtm/shared/services/hive_service.dart';

part 'add_or_update_visit_state.dart';
part 'add_or_update_visit_cubit.freezed.dart';

class AddOrUpdateVisitCubit extends Cubit<AddOrUpdateVisitState> {
  AddOrUpdateVisitCubit({
    required VisitService visitService,
    required HiveService hiveService,
  })  : _visitService = visitService,
        _hiveService = hiveService,
        super(const AddOrUpdateVisitState.initial()) {
    _visitService = visitService;
    _hiveService = hiveService;
  }

  late VisitService _visitService;
  late HiveService _hiveService;

  Future<void> addOrUpdateVisit({bool isEdit = false}) async {
    emit(const AddOrUpdateVisitState.loading());
    try {
      final persistedVisit = _hiveService.getVisitDetails();
      // Validation: check required fields
      if (persistedVisit.customerId == 0) {
        emit(const AddOrUpdateVisitState.error('Please select a customer'));
        return;
      }
      if (persistedVisit.status.isEmpty) {
        emit(const AddOrUpdateVisitState.error('Please select a status'));
        return;
      }
      if (persistedVisit.location.isEmpty) {
        emit(const AddOrUpdateVisitState.error('Please enter a location'));
        return;
      }
      if (persistedVisit.visitDate.toString().isEmpty) {
        emit(const AddOrUpdateVisitState.error('Please select a visit date'));
        return;
      }

      if (isEdit) {
        await _visitService.updateVisit(persistedVisit);
      } else {
        await _visitService.createVisit(persistedVisit);
      }

      _hiveService.clearVisitDetails();

      emit(AddOrUpdateVisitState.success(isEdit: isEdit));
    } catch (e) {
      Logger().f(e);
      emit(const AddOrUpdateVisitState.error('Something went wrong'));
    }
  }
}
