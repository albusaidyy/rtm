import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/data/services/visit_service.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/features/visit_tracker/visits/visits_page.dart';
import 'package:rtm/utils/singletons.dart';

class RtmRouter {
  static GoRouter get router => _router;

  static const visits = '/';

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: visits,
        name: visits,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              GetVisitsCubit(visitService: getIt<VisitService>()),
          child: const VisitsPage(),
        ),
      ),
    ],
  );
}
