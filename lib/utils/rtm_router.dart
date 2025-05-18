import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/visits/visits_page.dart';

class RtmRouter {
  static GoRouter get router => _router;

  static const visits = '/';

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: visits,
        name: visits,
        builder: (context, state) => const VisitsPage(),
      ),
    ],
  );
}
