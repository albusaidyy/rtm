import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rtm/counter/counter.dart';
import 'package:rtm/features/visit_tracker/data/services/activity_services.dart';
import 'package:rtm/features/visit_tracker/data/services/customer_services.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/services/visit_service.dart';

final getIt = GetIt.instance;

void setupSingletons() {
  getIt
    ..registerSingleton<VisitService>(VisitServiceImpl())
    ..registerSingleton<CustomerService>(CustomerServiceImpl())
    ..registerSingleton<ActivityService>(ActivityServiceImpl());
}

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider(
          create: (_) => GetVisitsCubit(
            visitService: getIt<VisitService>(),
            customerService: getIt<CustomerService>(),
            activityService: getIt<ActivityService>(),
          ),
        ),
        BlocProvider(
          create: (_) => CounterCubit(),
        ),
      ];
}
