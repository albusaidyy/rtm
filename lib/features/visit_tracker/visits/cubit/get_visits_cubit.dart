import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rtm/features/visit_tracker/data/services/visit_service.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/visit.dart';

part 'get_visits_cubit.freezed.dart';
part 'get_visits_state.dart';

class GetVisitsCubit extends Cubit<GetVisitsState> {
  GetVisitsCubit(VisitService visitService)
      : super(const GetVisitsState.initial()) {
    _visitService = visitService;
  }

  late VisitService _visitService;

  Future<void> getVisits() async {
    emit(const GetVisitsState.loading());
    final visits = await _visitService.getVisits();
    emit(GetVisitsState.loaded(visits));
  }
}
