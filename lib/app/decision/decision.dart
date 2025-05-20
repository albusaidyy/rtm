import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
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
    bool? user;
    user = true;
    if (user == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GoRouter.of(context).go(RtmRouter.visits);
      });
    }

    // if (user == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     GoRouter.of(context).go(RtmRouter.getStarted);
    //   });
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
