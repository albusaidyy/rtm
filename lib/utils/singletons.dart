import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rtm/counter/counter.dart';
import 'package:rtm/features/visit_tracker/data/services/visit_service.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';

final getIt = GetIt.instance;

void setupSingletons() {
  getIt.registerSingleton<VisitService>(VisitServiceImpl());
}

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider(
          create: (_) => GetVisitsCubit(visitService: getIt<VisitService>()),
        ),
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
      ];
}
