import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rtm/features/visit_tracker/add_visit/cubit/cubit/add_or_update_visit_cubit.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/data/services/visit_service.dart';
import 'package:rtm/shared/services/hive_service.dart';
import 'package:rtm/utils/rtm_config.dart';
import 'package:rtm/utils/singletons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabaseUrl =
      '${RtmConfig.instance!.values.urlScheme}://${RtmConfig.instance!.values.baseDomain}/';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: RtmConfig.instance!.values.supabaseAnonKey,
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  setupSingletons();

  try {
    await getIt<HiveService>().initBoxes();
  } on Exception catch (e) {
    Logger().e(e);
    await getIt<HiveService>().resetDatabase();
  } on Object catch (e) {
    Logger().e(e);
    // This will catch Error types (including TypeError)
    // and any other non-Exception objects
    await getIt<HiveService>().resetDatabase();
  }

  Bloc.observer = const AppBlocObserver();
  // Add cross-flavor configuration here

  runApp(
    MultiBlocProvider(
      providers: [
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
        BlocProvider(
          create: (_) => AddOrUpdateVisitCubit(
            visitService: getIt<VisitService>(),
            hiveService: getIt<HiveService>(),
          ),
        ),
      ],
      child: await builder(),
    ),
  );
}
