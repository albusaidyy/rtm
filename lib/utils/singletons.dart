import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/data/services/activity_services.dart';
import 'package:rtm/features/visit_tracker/data/services/customer_services.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/services/visit_service.dart';
import 'package:rtm/shared/services/hive_service.dart';

final getIt = GetIt.instance;

void setupSingletons() {
  getIt
    ..registerSingleton<HiveService>(HiveServiceImpl())
    ..registerSingleton<VisitService>(VisitServiceImpl())
    ..registerSingleton<CustomerService>(CustomerServiceImpl())
    ..registerSingleton<ActivityService>(ActivityServiceImpl());
}

class Singletons {
  static List<BlocProvider> registerCubits() => [
        BlocProvider(
          create: (_) => GetVisitsCubit(
            visitService: getIt<VisitService>(),
            hiveService: getIt<HiveService>(),
          ),
        ),
        BlocProvider(
          create: (_) => GetCustomersCubit(
            customerService: getIt<CustomerService>(),
            hiveService: getIt<HiveService>(),
          ),
        ),
        BlocProvider(
          create: (_) => GetActivitiesCubit(
            activityService: getIt<ActivityService>(),
            hiveService: getIt<HiveService>(),
          ),
        ),
      ];
}
