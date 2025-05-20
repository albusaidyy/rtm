import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rtm/features/visit_tracker/cubit/_index.dart';
import 'package:rtm/features/visit_tracker/visits/cubit/get_visits_cubit.dart';
import 'package:rtm/utils/color_palette.dart';
import 'package:rtm/utils/rtm_router.dart';

class DecisionPage extends StatefulWidget {
  const DecisionPage({
    super.key,
  });

  @override
  State<DecisionPage> createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final currentRoutePathNotifier = ValueNotifier<String>('');
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    //Fetch data
    context.read<GetActivitiesCubit>().getActivities();
    context.read<GetCustomersCubit>().getCustomers();
    context.read<GetVisitsCubit>().getVisits();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // simulating authentication
    // final user = getIt<HiveService>().getAuthData();
    // if (user != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     GoRouter.of(context).go(RtmRouter.visits);
    //   });
    // }

    // if (user == null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //     //simulate user login
      //     final user = User(
      //       'john.doe@example.com',
      //       'John Doe',
      //       '1',
      //     );
      //     //
      //     getIt<HiveService>().setAuthData(
      //       AuthenticatedUser(
      //         '1234567890',
      //         user,
      //       ),
      //     );
      //     Future.delayed(const Duration(seconds: 3), () {
      //       if (!context.mounted) return;
      GoRouter.of(context).go(RtmRouter.visits);
    // });
      });
    // }

    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      body: Align(
        child: Image.asset(
          'assets/app_icon/app_icon.png',
          height: 150,
        ),
      ),
    );
  }
}
