import 'package:go_router/go_router.dart';
import 'package:rtm/app/decision/decision.dart';
import 'package:rtm/features/visit_tracker/add_visit/add_or_update_visit.dart';
import 'package:rtm/features/visit_tracker/add_visit/select_customer_dropdown.dart';
import 'package:rtm/features/visit_tracker/add_visit/select_status.dart';
import 'package:rtm/features/visit_tracker/data/_index.dart';
import 'package:rtm/features/visit_tracker/visits/data/models/edit_visit_dto.dart';
import 'package:rtm/features/visit_tracker/visits/visits_page.dart';

class RtmRouter {
  static GoRouter get router => _router;

  static const decision = '/';

  static const visits = '/visits';
  static const addOrUpdateVisit = '/add-or-update-visit';
  static const selectStatus = '/select-status';
  static const selectCustomer = '/select-customer';

  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: decision,
        name: decision,
        builder: (context, state) => const DecisionPage(),
      ),
      GoRoute(
        path: visits,
        name: visits,
        builder: (context, state) => const VisitsPage(),
      ),
      GoRoute(
        path: addOrUpdateVisit,
        name: addOrUpdateVisit,
        builder: (context, state) {
          final editVisitDTO = state.extra as EditVisitDTO?;

          return AddOrUpdateVisit(
            isEdit: editVisitDTO?.isEdit ?? false,
            visit: editVisitDTO?.visit,
          );
        },
      ),
      GoRoute(
        path: selectStatus,
        name: selectStatus,
        builder: (context, state) {
          final selectedStatus = state.extra! as void Function(String status);
          return SelectStatusPage(
            selectedStatus: selectedStatus,
          );
        },
      ),
      GoRoute(
        path: selectCustomer,
        name: selectCustomer,
        builder: (context, state) {
          final selectedCustomer =
              state.extra! as void Function(Customer customer);
          return SelectCustomerDropdown(
            selectedCustomer: selectedCustomer,
          );
        },
      ),
    ],
  );
}
