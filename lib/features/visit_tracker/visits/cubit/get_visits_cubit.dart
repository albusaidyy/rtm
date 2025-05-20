import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';
import 'package:rtm/features/visit_tracker/visits/data/services/visit_service.dart';
import 'package:rtm/shared/services/hive_service.dart';

part 'get_visits_state.dart';
part 'get_visits_cubit.freezed.dart';

class GetVisitsCubit extends Cubit<GetVisitsState> {
  GetVisitsCubit({
    required VisitService visitService,
    required HiveService hiveService,
  })  : _visitService = visitService,
        _hiveService = hiveService,
        super(const GetVisitsState.initial()) {
    _visitService = visitService;
    _hiveService = hiveService;
  }

  late VisitService _visitService;
  late HiveService _hiveService;

  Future<void> getVisits() async {
    emit(const GetVisitsState.loading());
    try {
      final visits = await _visitService.getVisits();
      // we can now persist the visits locally
      _hiveService.persistVisits(visits);
      emit(GetVisitsState.loaded(visits));
    } catch (e) {
      emit(const GetVisitsState.error('Oops! Something went wrong'));
    }
  }
}
